# Get public IP
$ip = (Invoke-RestMethod -Uri "https://api.ipify.org")

# Get username
$user = $env:USERNAME

# Get machine / Windows info
$os = (Get-CimInstance Win32_OperatingSystem).Caption

# Get time
$time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Documents folder
$doc = [Environment]::GetFolderPath("MyDocuments")
$out = Join-Path $doc "ip.txt"

# Compose line
$line = "$time | $user | $os | IP: $ip"

# Write (append, not overwrite)
Add-Content -Path $out -Value $line

Read-Host "Press Enter to close"
