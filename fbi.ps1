# FBI Hack Simulator - ULTIMATE EDITION
# Windows PowerShell Version with ALL enhancements

# ==================== CONFIGURATION ====================
$script:config = @{
    AnimationSpeed = 50      # milliseconds (adjustable)
    SoundEnabled = $true     # Enable/disable beeps
    MatrixSpeed = 30         # Matrix effect speed
    GlitchChance = 0.05      # 5% chance of glitch
    DetectionChance = 0.15   # 15% chance of detection
}

# ==================== SOUND EFFECTS ====================
function Play-Beep {
    param([int]$frequency = 800, [int]$duration = 200)
    if ($script:config.SoundEnabled) {
        [console]::beep($frequency, $duration)
    }
}

function Play-CriticalBeep {
    if ($script:config.SoundEnabled) {
        [console]::beep(1000, 100)
        Start-Sleep -Milliseconds 50
        [console]::beep(1200, 100)
        Start-Sleep -Milliseconds 50
        [console]::beep(1400, 150)
    }
}

function Play-SuccessBeep {
    if ($script:config.SoundEnabled) {
        [console]::beep(600, 100)
        [console]::beep(800, 150)
    }
}

function Play-ErrorBeep {
    if ($script:config.SoundEnabled) {
        [console]::beep(200, 300)
        Start-Sleep -Milliseconds 50
        [console]::beep(150, 400)
    }
}

# ==================== VISUAL EFFECTS ====================
function Show-ProgressBar {
    param(
        [string]$Activity,
        [int]$Total = 100,
        [string]$Color = "Green"
    )

    $step = 1
    for ($i = 0; $i -le $Total; $i += $step) {

        if ($i -gt $Total) { $i = $Total }

        $percent = $i
        $completed = [math]::Floor($percent / 5)
        $remaining = 20 - $completed

        $bar = "█" * $completed + "░" * $remaining

        Write-Host -NoNewline "`r[$bar] $percent% - $Activity" -ForegroundColor $Color

        # Event-based sound (consistent)
        if ($percent -eq 0) {
            Play-Beep -frequency 700 -duration 150
        }
        elseif ($percent -eq 100) {
            Play-Beep -frequency 1200 -duration 300
        }

        Start-Sleep -Milliseconds $script:config.AnimationSpeed
    }
    Write-Host ""
}

function Show-MatrixRain {
    param([int]$Lines = 15)
    
    $chars = "0123456789ABCDEF!@#$%^&*()".ToCharArray()
    
    for ($i = 0; $i -lt $Lines; $i++) {
        $line = ""
        for ($j = 0; $j -lt 80; $j++) {
            $line += $chars | Get-Random
        }
        Write-Host $line -ForegroundColor Green
        Start-Sleep -Milliseconds $script:config.MatrixSpeed
    }
}

function Show-GlitchEffect {
    $original = $host.UI.RawUI.ForegroundColor
    
    for ($i = 0; $i -lt 5; $i++) {
        $host.UI.RawUI.ForegroundColor = @('Red','Green','Blue','Yellow','Magenta','Cyan') | Get-Random
        Write-Host "█▓▒░█▓▒░█▓▒░█▓▒░█▓▒░█▓▒░█▓▒░█▓▒░█▓▒░█▓▒░█▓▒░█▓▒░█▓▒░█▓▒░█▓▒░" -NoNewline
        Start-Sleep -Milliseconds 50
        Write-Host "`r                                                                      " -NoNewline
        Start-Sleep -Milliseconds 50
    }
    
    $host.UI.RawUI.ForegroundColor = $original
    Write-Host "`r"
}

function Show-DataStream {
    param([int]$Duration = 3)
    
    $end = (Get-Date).AddSeconds($Duration)
    
    while ((Get-Date) -lt $end) {
        $hex = -join ((0..15) | ForEach-Object { '{0:X}' -f (Get-Random -Maximum 16) })
        Write-Host "0x$hex" -ForegroundColor Cyan -NoNewline
        Write-Host " | " -NoNewline
        $binary = -join ((1..8) | ForEach-Object { Get-Random -Maximum 2 })
        Write-Host $binary -ForegroundColor Green -NoNewline
        Write-Host " | " -NoNewline
        $data = Get-Random -Minimum 100 -Maximum 999
        Write-Host "$data KB/s" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 100
    }
}

function Clear-WithTransition {
    for ($i = 0; $i -lt 3; $i++) {
        Clear-Host
        Start-Sleep -Milliseconds 50
    }
}

# ==================== UTILITY FUNCTIONS ====================
function Get-RealIP {
    try {
        $response = Invoke-WebRequest -Uri "https://www.whatsmyip.org" -UseBasicParsing -TimeoutSec 5
        $match = $response.Content | Select-String -Pattern '\b\d{1,3}(\.\d{1,3}){3}\b' | Select-Object -First 1
        if ($match) {
            return $match.Matches.Value
        } else {
            return "UNKNOWN"
        }
    }
    catch {
        return "UNKNOWN"
    }
}

function Get-RandomMAC {
    return -join ((1..6) | ForEach-Object { '{0:X2}' -f (Get-Random -Maximum 256) }) -replace '(.{2})','$1:' -replace ':$'
}

function Write-Slow {
    param([string]$text, [int]$speed = 20)
    foreach ($char in $text.ToCharArray()) {
        Write-Host -NoNewline $char
        Start-Sleep -Milliseconds $speed
    }
    Write-Host ""
}

function Test-Detection {
    if ((Get-Random -Minimum 1 -Maximum 100) -lt ($script:config.DetectionChance * 100)) {
        Show-DetectionAlert
        return $true
    }
    return $false
}

function Show-DetectionAlert {
    Clear-WithTransition
    Play-ErrorBeep
    
    $host.UI.RawUI.ForegroundColor = "Red"
    $host.UI.RawUI.BackgroundColor = "Black"
    
    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════════╗" -ForegroundColor Red
    Write-Host "  ║                                                            ║" -ForegroundColor Red
    Write-Host "  ║           ⚠️  INTRUSION DETECTED  ⚠️                        ║" -ForegroundColor Red
    Write-Host "  ║                                                            ║" -ForegroundColor Red
    Write-Host "  ║         SECURITY SYSTEMS ACTIVATED                         ║" -ForegroundColor Red
    Write-Host "  ║         INITIATING COUNTER-MEASURES                        ║" -ForegroundColor Red
    Write-Host "  ║                                                            ║" -ForegroundColor Red
    Write-Host "  ╚════════════════════════════════════════════════════════════╝" -ForegroundColor Red
    Write-Host ""
    
    Play-CriticalBeep
    
    Write-Host "[SYSTEM] Tracing connection source..." -ForegroundColor Yellow
    Start-Sleep 1
    Write-Host "[SYSTEM] IP Address: $(Get-RandomIP) - LOGGED" -ForegroundColor Yellow
    Start-Sleep 1
    Write-Host "[SYSTEM] Deploying honeypot..." -ForegroundColor Yellow
    Start-Sleep 1
    Write-Host "[SYSTEM] Severing connection..." -ForegroundColor Yellow
    Start-Sleep 1
    
    Show-GlitchEffect
    
    Write-Host ""
    Write-Host "[CONNECTION TERMINATED]" -ForegroundColor Red
    Write-Host ""
    
    Play-ErrorBeep
    
    Start-Sleep 2
    Read-Host "Press Enter to return to menu"
}

function Show-SystemInfo {
    Clear-WithTransition
    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "  ║           COMPROMISED SYSTEM INFORMATION                   ║" -ForegroundColor Cyan
    Write-Host "  ╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    
    $fakeData = @{
        "Hostname" = "FBI-DC-0$(Get-Random -Minimum 1 -Maximum 9)"
        "OS" = "Windows Server 2022 Datacenter"
        "IP Address" = Get-RandomIP
        "MAC Address" = Get-RandomMAC
        "Domain" = "FBI.GOV.INTERNAL"
        "CPU" = "Intel Xeon E5-2698 v4 @ 2.20GHz"
        "RAM" = "$(Get-Random -Minimum 64 -Maximum 256) GB"
        "Logged Users" = Get-Random -Minimum 15 -Maximum 47
        "Active Connections" = Get-Random -Minimum 100 -Maximum 500
        "Firewall" = "DISABLED"
        "Antivirus" = "DISABLED"
        "Admin Password Hash" = "5f4dcc3b5aa765d61d8327deb882cf99"
    }
    
    foreach ($key in $fakeData.Keys) {
        Write-Host "  $key`: " -NoNewline -ForegroundColor Green
        Write-Host $fakeData[$key] -ForegroundColor White
        Start-Sleep -Milliseconds 200
    }
    
    Write-Host ""
    Play-SuccessBeep
    Read-Host "Press Enter to continue"
}

# ==================== MAIN MENU ====================
function Show-Menu {
    Clear-WithTransition
    
    Write-Host ""
    Write-Host "     ███████╗██████╗ ██╗    ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗     " -ForegroundColor Red
    Write-Host "     ██╔════╝██╔══██╗██║    ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║     " -ForegroundColor Red
    Write-Host "     █████╗  ██████╔╝██║       ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║     " -ForegroundColor Red
    Write-Host "     ██╔══╝  ██╔══██╗██║       ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║     " -ForegroundColor Red
    Write-Host "     ██║     ██████╔╝██║       ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗" -ForegroundColor Red
    Write-Host "     ╚═╝     ╚═════╝ ╚═╝       ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝" -ForegroundColor Red
    Write-Host ""
    Write-Host "                          ╔═════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "                          ║   CLASSIFIED ACCESS SYSTEM v5.0.0      ║" -ForegroundColor Green
    Write-Host "                          ╚═════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "     ┌───────────────────────────────────┬───────────────────────────────────┐"
    Write-Host "     │  [1]  FBI Database Hack           │  [10] SQL Injection               │"
    Write-Host "     │  [2]  Delete System32             │  [11] DDoS Attack                 │"
    Write-Host "     │  [3]  Network Infiltration        │  [12] Ransomware Encryption       │"
    Write-Host "     │  [4]  Crypto Mining               │  [13] Keylogger Installation      │"
    Write-Host "     │  [5]  Password Cracker            │  [14] WiFi Password Cracker       │"
    Write-Host "     │  [6]  Track Suspects (GPS)        │  [15] Email Phishing Campaign     │"
    Write-Host "     │  [7]  Agent Profiles              │  [16] Show System Info            │"
    Write-Host "     │  [8]  Satellite Uplink            │  [17] Settings                    │"
    Write-Host "     │  [9]  Download Files              │  [18] Exit                        │"
    Write-Host "     └───────────────────────────────────┴───────────────────────────────────┘"
    Write-Host ""
}

# ==================== NEW HACKING OPTIONS ====================

function Start-SQLInjection {
    Clear-WithTransition
    Play-Beep
    
    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "  ║           SQL INJECTION ATTACK SIMULATOR                   ║" -ForegroundColor Cyan
    Write-Host "  ╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    
    if (Test-Detection) { return }
    
    Write-Host "[TARGET] Scanning for SQL injection vulnerabilities..." -ForegroundColor Yellow
    Start-Sleep 1
    
    $targets = @(
        "login.php?user=admin",
        "search.php?q=data",
        "profile.php?id=1",
        "admin/dashboard.php"
    )
    
    foreach ($target in $targets) {
        Write-Host "[SCAN] Testing: $target" -ForegroundColor Green
        Start-Sleep -Milliseconds 300
    }
    
    Write-Host ""
    Write-Host "[FOUND] Vulnerable endpoint: login.php?user=" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    
    Write-Host "Enter SQL injection payload:" -ForegroundColor Yellow
    Write-Host -NoNewline "> " -ForegroundColor Green
    $payload = Read-Host
    
    if ([string]::IsNullOrWhiteSpace($payload)) {
        $payload = "admin' OR '1'='1"
    }
    
    Write-Host ""
    Write-Host "[INJECTING] $payload" -ForegroundColor Cyan
    Show-ProgressBar -Activity "Executing SQL injection" -Color Cyan
    
    Write-Host ""
    Write-Host "[SUCCESS] Authentication bypassed!" -ForegroundColor Green
    Write-Host "[SUCCESS] Retrieved 15,847 user records" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Sample data retrieved:" -ForegroundColor Yellow
    for ($i = 1; $i -le 5; $i++) {
        $email = "user$i@target.com"
        $hash = -join ((1..32) | ForEach-Object { '{0:x}' -f (Get-Random -Maximum 16) })
        Write-Host "  [$i] $email | Hash: $hash" -ForegroundColor White
        Start-Sleep -Milliseconds 200
    }
    
    Write-Host ""
    Play-SuccessBeep
    Read-Host "Press Enter to continue"
}

function Start-DDoSAttack {
    Clear-WithTransition
    Play-Beep
    
    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════════╗" -ForegroundColor Red
    Write-Host "  ║           DISTRIBUTED DENIAL OF SERVICE ATTACK             ║" -ForegroundColor Red
    Write-Host "  ╚════════════════════════════════════════════════════════════╝" -ForegroundColor Red
    Write-Host ""
    
    if (Test-Detection) { return }
    
    Write-Host "Enter target IP address:" -ForegroundColor Yellow
    Write-Host -NoNewline "> " -ForegroundColor Green
    $targetIP = Read-Host
    
    if ([string]::IsNullOrWhiteSpace($targetIP)) {
        $targetIP = Get-RandomIP
        Write-Host "Using default target: $targetIP" -ForegroundColor Cyan
    }
    
    Write-Host ""
    Write-Host "[BOTNET] Activating zombie network..." -ForegroundColor Yellow
    Start-Sleep 1
    
    $bots = Get-Random -Minimum 5000 -Maximum 15000
    Write-Host "[BOTNET] $bots bots online and ready" -ForegroundColor Green
    Play-Beep
    
    Write-Host ""
    Write-Host "[ATTACK] Initiating DDoS attack on $targetIP" -ForegroundColor Red
    Write-Host ""
    
    for ($i = 1; $i -le 20; $i++) {
        $botIP = Get-RandomIP
        $packets = Get-Random -Minimum 1000 -Maximum 9999
        $mbps = Get-Random -Minimum 100 -Maximum 999
        
        Write-Host "[BOT $botIP] Sending $packets packets/sec | $mbps Mbps" -ForegroundColor Cyan
        
        if ($i % 5 -eq 0) {
            Play-Beep -frequency (Get-Random -Minimum 600 -Maximum 1200) -duration 50
        }
        
        Start-Sleep -Milliseconds 200
    }
    
    Write-Host ""
    Show-ProgressBar -Activity "Overwhelming target server" -Color Red
    
    Write-Host ""
    Write-Host "[SUCCESS] Target server overwhelmed!" -ForegroundColor Green
    Write-Host "[SUCCESS] Server response time: TIMEOUT" -ForegroundColor Green
    Write-Host "[SUCCESS] Website is DOWN" -ForegroundColor Green
    
    Play-CriticalBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Start-Ransomware {
    Clear-WithTransition
    Play-CriticalBeep
    
    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════════╗" -ForegroundColor Red
    Write-Host "  ║           RANSOMWARE ENCRYPTION SIMULATOR                  ║" -ForegroundColor Red
    Write-Host "  ╚════════════════════════════════════════════════════════════╝" -ForegroundColor Red
    Write-Host ""
    
    if (Test-Detection) { return }
    
    Write-Host "[PAYLOAD] Deploying ransomware..." -ForegroundColor Yellow
    Show-ProgressBar -Activity "Uploading malicious payload" -Color Red
    
    Write-Host ""
    Write-Host "[RANSOMWARE] Scanning for valuable files..." -ForegroundColor Yellow
    Start-Sleep 1
    
    $fileTypes = @(".doc", ".docx", ".xls", ".xlsx", ".pdf", ".jpg", ".png", ".mp4", ".sql", ".db")
    $totalFiles = Get-Random -Minimum 5000 -Maximum 15000
    
    Write-Host "[SCAN] Found $totalFiles files to encrypt" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "[ENCRYPT] Generating RSA-4096 encryption keys..." -ForegroundColor Red
    Start-Sleep 1
    $key = -join ((1..64) | ForEach-Object { '{0:X}' -f (Get-Random -Maximum 16) })
    Write-Host "[KEY] $key" -ForegroundColor DarkGray
    
    Write-Host ""
    Write-Host "[ENCRYPT] Encrypting files..." -ForegroundColor Red
    
    for ($i = 1; $i -le 20; $i++) {
        $ext = $fileTypes | Get-Random
        $filename = "document_$(Get-Random -Minimum 100 -Maximum 999)$ext"
        $percent = [math]::Floor(($i / 20) * 100)
        
        Write-Host "  [ENCRYPTED] $filename → $filename.locked" -ForegroundColor Yellow
        
        if ($i % 3 -eq 0) {
            Play-Beep -frequency 1000 -duration 50
        }
        
        Start-Sleep -Milliseconds 150
    }
    
    Write-Host ""
    Show-ProgressBar -Activity "Finalizing encryption" -Total 100 -Color Red
    
    Clear-WithTransition
    
    # Ransom note
    $host.UI.RawUI.BackgroundColor = "Red"
    $host.UI.RawUI.ForegroundColor = "White"
    Clear-Host
    
    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════════╗"
    Write-Host "  ║                                                            ║"
    Write-Host "  ║              YOUR FILES HAVE BEEN ENCRYPTED!               ║"
    Write-Host "  ║                                                            ║"
    Write-Host "  ║  All your important files have been encrypted with        ║"
    Write-Host "  ║  military-grade RSA-4096 encryption.                       ║"
    Write-Host "  ║                                                            ║"
    Write-Host "  ║  Files encrypted: $totalFiles                                      ║"
    Write-Host "  ║                                                            ║"
    Write-Host "  ║  To decrypt your files, send 5 BTC to:                     ║"
    Write-Host "  ║  1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa                         ║"
    Write-Host "  ║                                                            ║"
    Write-Host "  ║  You have 72 hours before files are deleted permanently.   ║"
    Write-Host "  ║                                                            ║"
    Write-Host "  ╚════════════════════════════════════════════════════════════╝"
    Write-Host ""
    
    Play-CriticalBeep
    Start-Sleep 3
    
    $host.UI.RawUI.BackgroundColor = "Black"
    $host.UI.RawUI.ForegroundColor = "Green"
    Clear-Host
    
    Write-Host ""
    Write-Host "[SIMULATION COMPLETE]" -ForegroundColor Green
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Start-Keylogger {
    Clear-WithTransition
    Play-Beep
    
    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
    Write-Host "  ║           KEYLOGGER INSTALLATION SIMULATOR                 ║" -ForegroundColor Magenta
    Write-Host "  ╚════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
    Write-Host ""
    
    if (Test-Detection) { return }
    
    Write-Host "[PAYLOAD] Compiling keylogger..." -ForegroundColor Yellow
    Start-Sleep 1
    
    Write-Host "[STEALTH] Obfuscating code..." -ForegroundColor Yellow
    Show-ProgressBar -Activity "Applying anti-detection techniques" -Color Magenta
    
    Write-Host ""
    Write-Host "[DEPLOY] Installing keylogger..." -ForegroundColor Cyan
    Show-ProgressBar -Activity "Injecting into system processes" -Color Cyan
    
    Write-Host ""
    Write-Host "[INSTALL] Creating persistence..." -ForegroundColor Yellow
    Start-Sleep 1
    Write-Host "  [+] Registry key added: HKLM\Software\Microsoft\Windows\CurrentVersion\Run" -ForegroundColor Green
    Write-Host "  [+] Service installed: Windows Update Assistant" -ForegroundColor Green
    Write-Host "  [+] Autostart enabled" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "[ACTIVE] Keylogger is now monitoring..." -ForegroundColor Green
    Play-SuccessBeep
    
    Write-Host ""
    Write-Host "Captured keystrokes (last 30 seconds):" -ForegroundColor Yellow
    Start-Sleep 1
    
    $fakeKeystrokes = @(
        "password: Admin#2024",
        "email: director@fbi.gov",
        "credit card: 4532-****-****-7849",
        "social security: ***-**-4729",
        "bank login: https://chase.com username: jdoe password: Summer2024!"
    )
    
    foreach ($log in $fakeKeystrokes) {
        Write-Host "  [LOG] $log" -ForegroundColor White
        Play-Beep -frequency 800 -duration 50
        Start-Sleep -Milliseconds 500
    }
    
    Write-Host ""
    Write-Host "[SUCCESS] Keylogger installed and active" -ForegroundColor Green
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Start-WiFiCracker {
    Clear-WithTransition
    Play-Beep
    
    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "  ║           WIFI PASSWORD CRACKER SIMULATOR                  ║" -ForegroundColor Cyan
    Write-Host "  ╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    
    if (Test-Detection) { return }
    
    Write-Host "[SCAN] Scanning for nearby WiFi networks..." -ForegroundColor Yellow
    Start-Sleep 1
    
    $networks = @(
        @{SSID="FBI_Secure"; Signal="-45 dBm"; Encryption="WPA2-Enterprise"; Channel=6},
        @{SSID="NETGEAR_5G"; Signal="-62 dBm"; Encryption="WPA2-PSK"; Channel=149},
        @{SSID="Linksys_Guest"; Signal="-71 dBm"; Encryption="WPA2-PSK"; Channel=11},
        @{SSID="ATT_WiFi_2847"; Signal="-58 dBm"; Encryption="WPA2-PSK"; Channel=1},
        @{SSID="TP-LINK_Home"; Signal="-67 dBm"; Encryption="WPA2-PSK"; Channel=36}
    )
    
    Write-Host ""
    Write-Host "Networks found:" -ForegroundColor Green
    for ($i = 0; $i -lt $networks.Count; $i++) {
        $net = $networks[$i]
        Write-Host "  [$($i+1)] SSID: $($net.SSID) | Signal: $($net.Signal) | Security: $($net.Encryption)" -ForegroundColor White
        Start-Sleep -Milliseconds 300
    }
    
    Write-Host ""
    Write-Host "Select target network (1-$($networks.Count)):" -ForegroundColor Yellow
    Write-Host -NoNewline "> " -ForegroundColor Green
    $selection = Read-Host
    
    if ([string]::IsNullOrWhiteSpace($selection)) {
        $selection = "2"
    }
    
    $target = $networks[[int]$selection - 1]
    
    Write-Host ""
    Write-Host "[TARGET] $($target.SSID)" -ForegroundColor Cyan
    Write-Host "[METHOD] Bruteforce + Dictionary Attack" -ForegroundColor Yellow
    Write-Host ""
    
    Write-Host "[CAPTURE] Capturing WPA handshake..." -ForegroundColor Yellow
    Show-ProgressBar -Activity "Waiting for client connection" -Color Yellow
    
    Write-Host ""
    Write-Host "[SUCCESS] Handshake captured!" -ForegroundColor Green
    Play-SuccessBeep
    
    Write-Host ""
    Write-Host "[CRACK] Loading wordlist (10,000,000 passwords)..." -ForegroundColor Yellow
    Start-Sleep 1
    
    Write-Host "[CRACK] Starting bruteforce attack..." -ForegroundColor Red
    Write-Host ""
    
    $attempts = @("password123", "admin123", "welcome123", "qwerty123", "P@ssw0rd", "Summer2024", "WiFi2024!", "MyNetwork123", "SecurePass99")
    
    foreach ($attempt in $attempts) {
        Write-Host "  [TRYING] $attempt..." -ForegroundColor DarkGray
        Play-Beep -frequency (Get-Random -Minimum 400 -Maximum 800) -duration 30
        Start-Sleep -Milliseconds 300
    }
    
    Write-Host ""
    $password = "SecurePass99"
    Write-Host "[SUCCESS] Password cracked: $password" -ForegroundColor Green
    Play-CriticalBeep
    
    Write-Host ""
    Write-Host "[CONNECT] Connecting to network..." -ForegroundColor Yellow
    Show-ProgressBar -Activity "Authenticating" -Color Green
    
    Write-Host ""
    Write-Host "[SUCCESS] Connected to $($target.SSID)" -ForegroundColor Green
    Write-Host "[IP] Assigned: $(Get-RandomIP)" -ForegroundColor Cyan
    
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Start-PhishingCampaign {
    Clear-WithTransition
    Play-Beep
    
    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
    Write-Host "  ║           EMAIL PHISHING CAMPAIGN SIMULATOR                ║" -ForegroundColor Yellow
    Write-Host "  ╚════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow
    Write-Host ""
    
    if (Test-Detection) { return }
    
    Write-Host "[SETUP] Creating phishing infrastructure..." -ForegroundColor Yellow
    Start-Sleep 1
    
    Write-Host "  [+] Registering fake domain: secure-fbi-login.com" -ForegroundColor Green
    Start-Sleep -Milliseconds 500
    Write-Host "  [+] Cloning legitimate website..." -ForegroundColor Green
    Start-Sleep -Milliseconds 500
    Write-Host "  [+] Setting up email server..." -ForegroundColor Green
    Start-Sleep -Milliseconds 500
    Write-Host "  [+] Configuring SSL certificate..." -ForegroundColor Green
    
    Write-Host ""
    Write-Host "[EMAIL] Crafting phishing email..." -ForegroundColor Cyan
    Start-Sleep 1
    
    Write-Host ""
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
    Write-Host "From: IT Security <security@fbi.gov>" -ForegroundColor White
    Write-Host "Subject: [URGENT] Password Reset Required" -ForegroundColor White
    Write-Host ""
    Write-Host "Dear Employee," -ForegroundColor White
    Write-Host ""
    Write-Host "Our systems have detected unusual activity on your account." -ForegroundColor White
    Write-Host "Please reset your password immediately by clicking below:" -ForegroundColor White
    Write-Host ""
    Write-Host "[Reset Password Now]" -ForegroundColor Blue
    Write-Host ""
    Write-Host "This link will expire in 24 hours." -ForegroundColor White
    Write-Host ""
    Write-Host "- FBI IT Security Team" -ForegroundColor White
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
    
    Write-Host ""
    Write-Host "[CAMPAIGN] Sending emails to targets..." -ForegroundColor Yellow
    Start-Sleep 1
    
    $targets = Get-Random -Minimum 500 -Maximum 2000
    Show-ProgressBar -Activity "Sending $targets phishing emails" -Color Yellow
    
    Write-Host ""
    Write-Host "[MONITOR] Tracking email opens and clicks..." -ForegroundColor Cyan
    Start-Sleep 2
    
    $opened = Get-Random -Minimum 200 -Maximum 800
    $clicked = Get-Random -Minimum 50 -Maximum 300
    $credentials = Get-Random -Minimum 20 -Maximum 150
    
    Write-Host ""
    Write-Host "Campaign Results:" -ForegroundColor Green
    Write-Host "  Emails sent: $targets" -ForegroundColor White
    Write-Host "  Emails opened: $opened ($(([math]::Round($opened/$targets * 100, 1)))%)" -ForegroundColor White
    Write-Host "  Links clicked: $clicked ($(([math]::Round($clicked/$targets * 100, 1)))%)" -ForegroundColor White
    Write-Host "  Credentials captured: $credentials ($(([math]::Round($credentials/$targets * 100, 1)))%)" -ForegroundColor Yellow
    
    Write-Host ""
    Write-Host "Sample captured credentials:" -ForegroundColor Yellow
    for ($i = 1; $i -le 5; $i++) {
        $user = "employee$((Get-Random -Minimum 100 -Maximum 999))"
        $pass = -join ((1..12) | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 126) })
        Write-Host "  [$i] $user@fbi.gov : $pass" -ForegroundColor White
        Start-Sleep -Milliseconds 300
    }
    
    Write-Host ""
    Play-SuccessBeep
    Write-Host "[SUCCESS] Phishing campaign completed!" -ForegroundColor Green
    Write-Host ""
    Read-Host "Press Enter to continue"
}
# ==================== ENHANCED ORIGINAL FUNCTIONS ====================

function FBI-Hack-Start {
    Clear-WithTransition
    Play-Beep
    
    Write-Host ""
    Write-Host "  ███████╗██████╗ ██╗    ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗" -ForegroundColor Green
    Write-Host "  ██╔════╝██╔══██╗██║    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝" -ForegroundColor Green
    Write-Host "  █████╗  ██████╔╝██║    ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗  " -ForegroundColor Green
    Write-Host "  ██╔══╝  ██╔══██╗██║    ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝  " -ForegroundColor Green
    Write-Host "  ██║     ██████╔╝██║    ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗" -ForegroundColor Green
    Write-Host "  ╚═╝     ╚═════╝ ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "                        [CLASSIFIED - TOP SECRET - EYES ONLY]" -ForegroundColor Yellow
    Write-Host ""
    Start-Sleep -Milliseconds 500
    
    if (Test-Detection) { return }
    
    # PHASE 1: Biometric
    Write-Slow "[PHASE 1/6] Biometric Authentication Required"
    Write-Host ""
    Write-Slow "Place finger on scanner..."
    Play-Beep -frequency 800 -duration 100
    Start-Sleep 1
    Write-Host ""
    Write-Host "     ┌─────────────────────────┐"
    Write-Host "     │   FINGERPRINT SCANNER   │"
    Write-Host "     │                         │"
    Write-Host "     │       ╔═══════╗         │"
    Write-Host "     │      ║ ░░░░░░░║         │" -ForegroundColor DarkGray
    
    # Animated scanning
    for ($i = 0; $i -lt 3; $i++) {
        Write-Host "`r     │      ║░███░███░║         │" -ForegroundColor Green -NoNewline
        Play-Beep -frequency 1000 -duration 50
        Start-Sleep -Milliseconds 300
        Write-Host "`r     │      ║ ░░░░░░░║         │" -ForegroundColor DarkGray -NoNewline
        Start-Sleep -Milliseconds 300
    }
    Write-Host ""

    
    Write-Host ""
    Write-Host "     │      ║░███░███░║         │" -ForegroundColor Green
    Write-Host "     │      ║░░█████░░║         │" -ForegroundColor Green
    Write-Host "     │      ║░██░█░██░║         │" -ForegroundColor Green
    Write-Host "     │       ╚═══════╝         │"
    Write-Host "     │                         │"
    Write-Host "     │   SCANNING...           │" -ForegroundColor Yellow
    Write-Host "     └─────────────────────────┘"
    Start-Sleep 2
    
    Clear-WithTransition
    Write-Host ""
    Write-Host "  ███████╗██████╗ ██╗    ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗" -ForegroundColor Green
    Write-Host "  ██╔════╝██╔══██╗██║    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝" -ForegroundColor Green
    Write-Host "  █████╗  ██████╔╝██║    ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗  " -ForegroundColor Green
    Write-Host "  ██╔══╝  ██╔══██╗██║    ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝  " -ForegroundColor Green
    Write-Host "  ██║     ██████╔╝██║    ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗" -ForegroundColor Green
    Write-Host "  ╚═╝     ╚═════╝ ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host ""
    Write-Host "     ┌─────────────────────────┐"
    Write-Host "     │   RETINAL SCANNER       │"
    Write-Host "     │                         │"
    Write-Host "     │         ▓▓▓▓▓           │" -ForegroundColor DarkGray
    Write-Host "     │       ▓▓░░░░░▓▓         │" -ForegroundColor DarkGray
    Write-Host "     │      ▓░░░██░░░▓         │" -ForegroundColor Cyan
    Write-Host "     │      ▓░░░██░░░▓         │" -ForegroundColor Cyan
    Write-Host "     │       ▓▓░░░░░▓▓         │" -ForegroundColor DarkGray
    Write-Host "     │         ▓▓▓▓▓           │" -ForegroundColor DarkGray
    Write-Host "     │                         │"
    Write-Host "     │   SCANNING RETINA...    │" -ForegroundColor Yellow
    Write-Host "     └─────────────────────────┘"
    
    # Retinal scan animation (in-place redraw)
    for ($i = 0; $i -lt 5; $i++) {
        Write-Host "`r     │      ▓░░░██░░░▓         │" -ForegroundColor Cyan -NoNewline
        Play-Beep -frequency (1000 + ($i * 100)) -duration 50
        Start-Sleep -Milliseconds 150
        Write-Host "`r     │      ▓░░░░░░░▓         │" -ForegroundColor DarkGray -NoNewline
        Start-Sleep -Milliseconds 150
    }
    Write-Host ""

    
    Start-Sleep 1
    Write-Host ""
    Write-Host "[✓] BIOMETRIC MATCH - Director Level Clearance" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    Start-Sleep 1
    
    if (Test-Detection) { return }
    
    # PHASE 2: Connection
    Clear-WithTransition
    Write-Slow "[PHASE 2/6] Initiating secure connection to FBI mainframe..."
    Write-Host ""
    
    # Interactive password prompt
    Write-Host "Enter access credentials:" -ForegroundColor Yellow
    Write-Host -NoNewline "Username: " -ForegroundColor Cyan
    $username = Read-Host
    if ([string]::IsNullOrWhiteSpace($username)) { $username = "DIRECTOR" }
    
    Write-Host -NoNewline "Password: " -ForegroundColor Cyan
    $password = Read-Host -AsSecureString
    
    Write-Host ""
    Write-Slow "Validating credentials..."
    Show-ProgressBar -Activity "Authenticating $username" -Color Cyan
    
    Write-Host ""
    Write-Slow "Connecting to: fbi-sentinel.gov ($(Get-RandomIP):8443)"
    Start-Sleep 1
    Write-Host "[*] Establishing encrypted tunnel..." -ForegroundColor Yellow
    Show-DataStream -Duration 2
    Write-Host "[*] SSL/TLS Handshake... OK" -ForegroundColor Green
    Write-Host "[*] Certificate validation... OK" -ForegroundColor Green
    Start-Sleep 1
    Write-Host "[✓] SECURE CONNECTION ESTABLISHED" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Start-Sleep 1
    
    if (Test-Detection) { return }
    
    # PHASE 3: 2FA Bypass
    Write-Slow "[PHASE 3/6] Bypassing multi-factor authentication..."
    Write-Host ""
    Write-Host "[*] Intercepting 2FA token..." -ForegroundColor Yellow
    Show-ProgressBar -Activity "Packet sniffing" -Color Yellow
    
    $token = Get-Random -Minimum 100000 -Maximum 999999
    Write-Host "[*] Token captured: $token" -ForegroundColor Cyan
    Play-Beep -frequency 1200 -duration 100
    
    Write-Host "[*] Replaying authentication sequence..." -ForegroundColor Yellow
    Start-Sleep 1
    Write-Host "[✓] 2FA BYPASSED" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    Start-Sleep 1
    
    # Random glitch
    if ((Get-Random -Minimum 1 -Maximum 100) -lt ($script:config.GlitchChance * 100)) {
        Show-GlitchEffect
    }
    
    if (Test-Detection) { return }
    
    # PHASE 4: Security Disable
    Write-Slow "[PHASE 4/6] Disabling security systems..."
    Write-Host ""
    
    $securitySystems = @(
        "Firewall processes",
        "IDS/IPS monitoring",
        "Antivirus services",
        "Access logs",
        "Intrusion detection",
        "Network monitoring"
    )
    
    foreach ($system in $securitySystems) {
        Write-Host "[*] Killing $system..." -ForegroundColor Yellow -NoNewline
        Start-Sleep -Milliseconds 300
        Write-Host " DONE" -ForegroundColor Green
        Play-Beep -frequency 600 -duration 50
    }
    
    Start-Sleep 1
    Write-Host "[✓] ALL SECURITY SYSTEMS DISABLED" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    Start-Sleep 1
    
    if (Test-Detection) { return }
    
    # PHASE 5: Backdoor
    Write-Slow "[PHASE 5/6] Installing persistent backdoor..."
    Write-Host ""
    
    Write-Host "[*] Compiling payload..." -ForegroundColor Yellow
    Show-MatrixRain -Lines 5
    
    Show-ProgressBar -Activity "Uploading payload" -Color Red
    
    Write-Host ""
    Write-Host "[*] Configuring autostart..." -ForegroundColor Yellow -NoNewline
    Start-Sleep 1
    Write-Host " DONE" -ForegroundColor Green
    
    Write-Host "[*] Hiding process from task manager..." -ForegroundColor Yellow -NoNewline
    Start-Sleep 1
    Write-Host " DONE" -ForegroundColor Green
    
    Write-Host "[*] Creating persistence registry keys..." -ForegroundColor Yellow -NoNewline
    Start-Sleep 1
    Write-Host " DONE" -ForegroundColor Green
    
    Start-Sleep 1
    Write-Host "[✓] BACKDOOR INSTALLED - PERSISTENT ACCESS GRANTED" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    Start-Sleep 1
    
    # PHASE 6: Database Access
    Write-Slow "[PHASE 6/6] Accessing SENTINEL database..."
    Write-Host ""
    
    # Command injection sequence
    Write-Host "Injecting SQL commands:" -ForegroundColor Cyan
    $commands = @(
        "SELECT * FROM classified_operations;",
        "GRANT ALL PRIVILEGES ON *.* TO 'backdoor'@'%';",
        "UPDATE security_logs SET status='clean' WHERE timestamp > NOW();",
        "INSERT INTO authorized_users VALUES ('ghost', 'ADMIN');"
    )
    
    foreach ($cmd in $commands) {
        Write-Host "  > $cmd" -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 500
    }
    
    Write-Host ""
    Show-ProgressBar -Activity "Executing database queries" -Color Green
    
    Start-Sleep 1
    Write-Host ""
    Write-Host "[✓✓✓] FULL SYSTEM ACCESS GRANTED [✓✓✓]" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    Start-Sleep 1
    Read-Host "Press Enter to continue"
    
    FBI-Menu
}

function FBI-Menu {
    while ($true) {
        Clear-WithTransition
        Write-Host ""
        Write-Host "  ███████╗███████╗███╗   ██╗████████╗██╗███╗   ██╗███████╗██╗         " -ForegroundColor Green
        Write-Host "  ██╔════╝██╔════╝████╗  ██║╚══██╔══╝██║████╗  ██║██╔════╝██║         " -ForegroundColor Green
        Write-Host "  ███████╗█████╗  ██╔██╗ ██║   ██║   ██║██╔██╗ ██║█████╗  ██║         " -ForegroundColor Green
        Write-Host "  ╚════██║██╔══╝  ██║╚██╗██║   ██║   ██║██║╚██╗██║██╔══╝  ██║         " -ForegroundColor Green
        Write-Host "  ███████║███████╗██║ ╚████║   ██║   ██║██║ ╚████║███████╗███████╗    " -ForegroundColor Green
        Write-Host "  ╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝    " -ForegroundColor Green
        Write-Host ""
        Write-Host "                        FBI DATABASE ACCESS SYSTEM" -ForegroundColor Yellow
        Write-Host "════════════════════════════════════════════════════════════════════════" -ForegroundColor Green
        Write-Host ""
        Write-Host "     [1] Track Suspects (GPS)          [7] Webcam Access"
        Write-Host "     [2] Criminal Records               [8] Download Files"
        Write-Host "     [3] Active Investigations          [9] Evidence Locker"
        Write-Host "     [4] Classified Documents          [10] Agent Profiles"
        Write-Host "     [5] Surveillance Footage          [11] Satellite Uplink"
        Write-Host "     [6] Witness Protection            [12] Back to Main Menu"
        Write-Host ""
        Write-Host "════════════════════════════════════════════════════════════════════════" -ForegroundColor Green
        
        $choice = Read-Host "SELECT DATABASE"
        
        try {
            switch ($choice) {
                "1" { Track-Suspects }
                "2" { Criminal-Records }
                "3" { Active-Investigations }
                "4" { Classified-Documents }
                "5" { Surveillance-Footage }
                "6" { Witness-Protection }
                "7" { Webcam-Access }
                "8" { Download-Files }
                "9" { Evidence-Locker }
                "10" { Agent-Profiles }
                "11" { Satellite-Uplink }
                "12" { return }
                default { 
                    Write-Host "Invalid option!" -ForegroundColor Red
                    Play-ErrorBeep
                    Start-Sleep 1
                }
            }
        }
        catch {
            Write-Host "Error: $_" -ForegroundColor Red
            Play-ErrorBeep
            Start-Sleep 2
        }
    }
}

function Track-Suspects {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[GPS TRACKING] Accessing real-time suspect locations..."
    Write-Host ""
    Show-ProgressBar -Activity "Connecting to GPS satellites" -Color Cyan
    
    Write-Host ""
    Write-Host "┌────────────────────────────────────────────────────────────────────┐"
    Write-Host "│                    ACTIVE SUSPECT TRACKING                         │"
    Write-Host "├────────────────────────────────────────────────────────────────────┤"
    Write-Host "│                                                                    │"
    
    $suspects = @(
        @{Name="John Martinez"; Status="ARMED AND DANGEROUS"; City="New York, NY"; Street="742 Broadway St"; Speed="45 MPH - Moving North"},
        @{Name="Sarah Chen"; Status="WANTED - CYBER CRIMES"; City="Los Angeles, CA"; Street="1523 Sunset Blvd"; Speed="STATIONARY"},
        @{Name="Michael Torres"; Status="FUGITIVE - DO NOT APPROACH"; City="Chicago, IL"; Street="891 Michigan Ave"; Speed="67 MPH - Moving East"}
    )
    
    $baseLats = @(40, 34, 41)
    $baseLons = @(-74, -118, -87)
    
    for ($i = 0; $i -lt $suspects.Count; $i++) {
        $suspect = $suspects[$i]
        $lat = $baseLats[$i] + (Get-Random -Maximum 10)
        $lon = $baseLons[$i] - (Get-Random -Maximum 10)
        $latDec = Get-Random -Maximum 9999
        $lonDec = Get-Random -Maximum 9999
        
        Write-Host "│  [SUSPECT #$(1847 + $i)] $($suspect.Name)" -NoNewline
        Write-Host (" " * (50 - $suspect.Name.Length)) -NoNewline
        Write-Host "│"
        Write-Host "│  Status: $($suspect.Status)" -NoNewline
        Write-Host (" " * (50 - $suspect.Status.Length)) -NoNewline
        Write-Host "│"
        Write-Host "│  Location: $lat.$latDec°N, $lon.$lonDec°W" -NoNewline -ForegroundColor Cyan
        Write-Host (" " * (33 - "$lat.$latDec°N, $lon.$lonDec°W".Length)) -NoNewline
        Write-Host "│"
        Write-Host "│  Address: $($suspect.Street), $($suspect.City)" -NoNewline
        Write-Host (" " * (50 - "$($suspect.Street), $($suspect.City)".Length)) -NoNewline
        Write-Host "│"
        Write-Host "│  Speed: $($suspect.Speed)" -NoNewline
        Write-Host (" " * (50 - $suspect.Speed.Length)) -NoNewline
        Write-Host "│"
        Write-Host "│  Last Update: $((Get-Random -Minimum 1 -Maximum 10)) seconds ago" -NoNewline
        Write-Host (" " * 36) -NoNewline
        Write-Host "│"
        Write-Host "│" -NoNewline
        Write-Host (" " * 68) -NoNewline
        Write-Host "│"
        
        Play-Beep -frequency 800 -duration 50
        Start-Sleep 1
    }
    
    Write-Host "└────────────────────────────────────────────────────────────────────┘"
    Write-Host ""
    Write-Host "[✓] 47 suspects being tracked in real-time" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Criminal-Records {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[DATABASE] Accessing criminal records..."
    Write-Host ""
    
    Show-ProgressBar -Activity "Querying NCIC database" -Color Yellow
    
    Write-Host ""
    $names = @("SMITH", "JOHNSON", "WILLIAMS", "BROWN", "JONES", "GARCIA", "MILLER", "DAVIS", "RODRIGUEZ", "MARTINEZ")
    
    for ($i = 1; $i -le 15; $i++) {
        $id = Get-Random -Maximum 999999
        $ssn = ""
        for ($j = 0; $j -lt 9; $j++) { $ssn += Get-Random -Maximum 10 }
        $name = $names | Get-Random
        $formatted_ssn = $ssn.Substring(0,3) + "-" + $ssn.Substring(3,2) + "-" + $ssn.Substring(5,4)
        Write-Host "[DB] Record #$id | Name: $name | SSN: $formatted_ssn | Status: EXTRACTED" -ForegroundColor Green
        
        Play-Beep -frequency (600 + ($i * 20)) -duration 30
        Start-Sleep -Milliseconds 150
    }
    
    Write-Host ""
    Write-Host "[✓] Downloaded 15,847 criminal records" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Active-Investigations {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[DATABASE] Retrieving active investigations..."
    Write-Host ""
    
    Show-ProgressBar -Activity "Accessing classified case files" -Color Red
    
    Write-Host ""
    $cases = @(
        "[CASE #47291] Operation Dark Web - Drug Trafficking - Status: ACTIVE",
        "[CASE #47292] Cyber Espionage - Foreign Interference - Status: CLASSIFIED",
        "[CASE #47293] Money Laundering - Organized Crime - Status: ACTIVE",
        "[CASE #47294] Terrorism Investigation - Threat Level: HIGH",
        "[CASE #47295] Kidnapping - Amber Alert - Status: URGENT",
        "[CASE #47296] White Collar Crime - Securities Fraud - Status: ACTIVE",
        "[CASE #47297] Human Trafficking - Multi-State - Status: CLASSIFIED",
        "[CASE #47298] Arson Investigation - Federal Property - Status: ACTIVE",
        "[CASE #47299] Political Corruption - Congress Member - Status: TOP SECRET",
        "[CASE #47300] Bank Robbery - Armed Suspects - Status: MANHUNT"
    )
    
    foreach ($case in $cases) {
        Write-Host $case -ForegroundColor Yellow
        Play-Beep -frequency 700 -duration 40
        Start-Sleep -Milliseconds 300
    }
    
    Write-Host ""
    Write-Host "[✓] 247 active investigations retrieved" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Classified-Documents {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[DATABASE] Downloading classified documents..."
    Write-Host ""
    
    $documents = @(
        @{Name="PROJECT_SENTINEL.pdf"; Size="127 MB"},
        @{Name="OPERATION_BLACKOUT.docx"; Size="43 MB"},
        @{Name="WITNESS_LIST_2024.xlsx"; Size="89 MB"},
        @{Name="SURVEILLANCE_PROTOCOLS.pdf"; Size="156 MB"},
        @{Name="ASSET_SEIZURE_RECORDS.pdf"; Size="201 MB"},
        @{Name="UNDERCOVER_AGENTS.xlsx"; Size="73 MB"},
        @{Name="INFORMANT_DATABASE.db"; Size="341 MB"}
    )
    
    foreach ($doc in $documents) {
        Write-Host "[DOWNLOADING] $($doc.Name) ($($doc.Size)) " -NoNewline -ForegroundColor Cyan
        Show-ProgressBar -Activity "" -Total 100 -Color Green
        Play-Beep -frequency 900 -duration 50
    }
    
    Write-Host ""
    Write-Host "[✓] 7 TOP SECRET documents downloaded (1.03 GB total)" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Surveillance-Footage {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[SURVEILLANCE] Accessing security camera feeds..."
    Write-Host ""
    
    $cameras = @(
        "[CAMERA 001] NYC - Times Square - ACTIVE - Recording",
        "[CAMERA 002] LA - Federal Building - ACTIVE - Recording",
        "[CAMERA 003] Chicago - O'Hare Airport - ACTIVE - Recording",
        "[CAMERA 004] Miami - Port Authority - ACTIVE - Recording",
        "[CAMERA 005] DC - Capitol Building - ACTIVE - Recording",
        "[CAMERA 006] Houston - FBI Field Office - ACTIVE - Recording",
        "[CAMERA 007] Phoenix - Border Checkpoint - ACTIVE - Recording"
    )
    
    foreach ($cam in $cameras) {
        Write-Host $cam -ForegroundColor Green
        Play-Beep -frequency 1000 -duration 30
        Start-Sleep -Milliseconds 200
    }
    
    Write-Host ""
    Write-Slow "[AUDIO] Accessing wiretap recordings..."
    Write-Host ""
    
    $wiretaps = @(
        "[WIRETAP 891] Target: John Martinez - Duration: 47:23",
        "[WIRETAP 892] Target: Sarah Chen - Duration: 31:56",
        "[WIRETAP 893] Target: Unknown - Duration: 1:14:09"
    )
    
    foreach ($tap in $wiretaps) {
        Write-Host "$tap - DOWNLOADING..." -ForegroundColor Yellow
        Show-ProgressBar -Activity "Decrypting audio" -Total 100 -Color Cyan
        Play-Beep -frequency 600 -duration 100
    }
    
    Write-Host ""
    Write-Host "[✓] 127 surveillance feeds accessed | 45 wiretaps downloaded" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Witness-Protection {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[DATABASE] Accessing Witness Protection Program..."
    Write-Host ""
    Write-Host "[⚠️  WARNING] This database contains HIGHLY SENSITIVE information" -ForegroundColor Red
    Play-CriticalBeep
    Start-Sleep 1
    
    Show-ProgressBar -Activity "Decrypting witness records" -Color Red
    
    Write-Host ""
    $witnesses = @(
        "[WITNESS ID: WP-2891] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED",
        "[WITNESS ID: WP-2892] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED",
        "[WITNESS ID: WP-2893] Name: [REDACTED] - Location: [REDACTED] - Status: RELOCATED",
        "[WITNESS ID: WP-2894] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED",
        "[WITNESS ID: WP-2895] Name: [REDACTED] - Location: [REDACTED] - Status: COMPROMISED",
        "[WITNESS ID: WP-2896] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED",
        "[WITNESS ID: WP-2897] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED"
    )
    
    foreach ($witness in $witnesses) {
        Write-Host $witness -ForegroundColor DarkGray
        Play-Beep -frequency 500 -duration 50
        Start-Sleep -Milliseconds 300
    }
    
    Write-Host ""
    Write-Host "[✓] 1,247 witness records accessed" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Agent-Profiles {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[DATABASE] Accessing FBI Agent Profiles..."
    Write-Host ""
    
    Show-ProgressBar -Activity "Retrieving personnel files" -Color Cyan
    
    Start-Sleep 1
    
    $agents = @(
        @{
            Name="Special Agent James Rodriguez"
            Badge="SA-47291"
            Division="Cyber Crimes"
            Clearance="Level 5 - Top Secret"
            Location="Washington D.C. Field Office"
            Status="ACTIVE - Currently on assignment"
            Cases="47 closed | 12 active"
        },
        @{
            Name="Special Agent Emily Carter"
            Badge="SA-39182"
            Division="Counter-Terrorism"
            Clearance="Level 6 - Classified"
            Location="New York Field Office"
            Status="ACTIVE - Undercover operation"
            Cases="89 closed | 8 active"
        },
        @{
            Name="Special Agent Michael Chen"
            Badge="SA-51847"
            Division="Organized Crime"
            Clearance="Level 5 - Top Secret"
            Location="Los Angeles Field Office"
            Status="ACTIVE - Field assignment"
            Cases="62 closed | 15 active"
        }
    )
    
    foreach ($agent in $agents) {
        Write-Host "════════════════════════════════════════════════════════════════════"
        Write-Host "  AGENT PROFILE" -ForegroundColor Yellow
        Write-Host "════════════════════════════════════════════════════════════════════"
        Write-Host "  Name: $($agent.Name)" -ForegroundColor White
        Write-Host "  Badge: $($agent.Badge)" -ForegroundColor Cyan
        Write-Host "  Division: $($agent.Division)" -ForegroundColor Green
        Write-Host "  Clearance: $($agent.Clearance)" -ForegroundColor Red
        Write-Host "  Location: $($agent.Location)" -ForegroundColor White
        Write-Host "  Status: $($agent.Status)" -ForegroundColor Yellow
        Write-Host "  Cases: $($agent.Cases)" -ForegroundColor White
        Write-Host "════════════════════════════════════════════════════════════════════"
        Write-Host ""
        Play-Beep -frequency 1100 -duration 100
        Start-Sleep 1
    }
    
    Write-Host "[✓] 3,847 agent profiles accessed" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Satellite-Uplink {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[SATELLITE] Establishing connection to surveillance satellites..."
    Write-Host ""
    Start-Sleep 1
    Write-Host "[*] Connecting to KEYHOLE-12 satellite network..." -ForegroundColor Yellow
    Show-ProgressBar -Activity "Establishing uplink" -Color Cyan
    
    Write-Host "[*] Authentication: ACCEPTED" -ForegroundColor Green
    Play-Beep -frequency 1200 -duration 100
    Write-Host "[*] Uplink established" -ForegroundColor Green
    Start-Sleep 1
    Write-Host "[✓] SATELLITE CONNECTION ACTIVE" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    Start-Sleep 1
    
    Write-Host "┌────────────────────────────────────────────────────────────────┐"
    Write-Host "│                  ACTIVE SATELLITES                             │"
    Write-Host "├────────────────────────────────────────────────────────────────┤"
    Write-Host "│                                                                │"
    Write-Host "│  [SAT-01] KEYHOLE-12A   - Orbit: 380km - Status: OPERATIONAL   │" -ForegroundColor Green
    Write-Host "│  [SAT-02] KEYHOLE-12B   - Orbit: 385km - Status: OPERATIONAL   │" -ForegroundColor Green
    Write-Host "│  [SAT-03] LACROSSE-5    - Orbit: 680km - Status: OPERATIONAL   │" -ForegroundColor Green
    Write-Host "│  [SAT-04] MERCURY-7     - Orbit: 420km - Status: OPERATIONAL   │" -ForegroundColor Green
    Write-Host "│                                                                │"
    Write-Host "└────────────────────────────────────────────────────────────────┘"
    Write-Host ""
    
    Write-Slow "[SATELLITE] Accessing real-time imaging..."
    Write-Host ""
    
    $coordinates = @(
        "40.7128°N, 74.0060°W (NYC)",
        "34.0522°N, 118.2437°W (LA)",
        "41.8781°N, 87.6298°W (Chicago)"
    )
    
    foreach ($coord in $coordinates) {
        Write-Host "[IMAGE] Target: $coord - Resolution: 0.3m" -ForegroundColor Cyan
        Play-Beep -frequency 900 -duration 50
        Start-Sleep -Milliseconds 400
    }
    
    Write-Host ""
    Write-Slow "[SATELLITE] Tracking mobile targets..."
    Write-Host ""
    Write-Host "[TRACKING] Vehicle plate: ABC-1234 - Last seen: 5 minutes ago" -ForegroundColor Yellow
    Write-Host "[TRACKING] Suspect: John Martinez - Current location acquired" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[✓] 4 satellites online | Real-time tracking active" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Webcam-Access {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[WEBCAM] Accessing remote webcam feeds..."
    Write-Host ""
    Start-Sleep 1
    Write-Host "[⚠️  WARNING] Unauthorized access to private devices" -ForegroundColor Red
    Play-CriticalBeep
    Start-Sleep 1
    Write-Host ""
    
    $webcams = @(
        "[WEBCAM 001] IP: $(Get-RandomIP) - Location: New York, NY - ACTIVE",
        "[WEBCAM 002] IP: $(Get-RandomIP) - Location: Los Angeles, CA - ACTIVE",
        "[WEBCAM 003] IP: $(Get-RandomIP) - Location: Chicago, IL - ACTIVE",
        "[WEBCAM 004] IP: $(Get-RandomIP) - Location: Houston, TX - ACTIVE",
        "[WEBCAM 005] IP: $(Get-RandomIP) - Location: Phoenix, AZ - ACTIVE",
        "[WEBCAM 006] IP: $(Get-RandomIP) - Location: Miami, FL - ACTIVE"
    )
    
    foreach ($cam in $webcams) {
        Write-Host $cam -ForegroundColor Green
        Play-Beep -frequency 1000 -duration 40
        Start-Sleep -Milliseconds 300
    }
    
    Write-Host ""
    Write-Slow "[RECORDING] Starting video capture..."
    Write-Host ""
    
    Show-ProgressBar -Activity "Recording footage" -Color Red
    
    Write-Host ""
    Write-Slow "[AUDIO] Accessing microphone feeds..."
    Write-Host ""
    
    Write-Host "[MIC 001] Device detected - Recording audio... ACTIVE" -ForegroundColor Yellow
    Write-Host "[MIC 002] Device detected - Recording audio... ACTIVE" -ForegroundColor Yellow
    Write-Host "[MIC 003] Device detected - Recording audio... ACTIVE" -ForegroundColor Yellow
    
    Write-Host ""
    Write-Host "[✓] 47 webcams accessed | 32 audio feeds active" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Download-Files {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[FILE TRANSFER] Downloading classified files to local system..."
    Write-Host ""
    Start-Sleep 1
    
    $downloadPath = "$env:USERPROFILE\Downloads\FBI_CLASSIFIED_DATA.txt"
    
    @"
════════════════════════════════════════════════════════════
 FBI CLASSIFIED DATABASE EXTRACT
 ACCESS LEVEL: TOP SECRET
 EXTRACTED: $(Get-Date)
════════════════════════════════════════════════════════════

 Ha! You thought you actually hacked the FBI, didn't you?

 This is just a harmless PowerShell script for fun.
 No real data was accessed or downloaded.
 No systems were harmed.

 Hope you enjoyed the show! ;)

════════════════════════════════════════════════════════════
"@ | Out-File -FilePath $downloadPath -Encoding UTF8
    
    Write-Host "[DOWNLOADING] FBI_CLASSIFIED_DATA.txt" -ForegroundColor Cyan
    Write-Host ""
    
    Show-ProgressBar -Activity "Transferring encrypted data" -Color Green
    
    Write-Host ""
    Write-Host "[✓] File downloaded to: $downloadPath" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    Write-Host "Opening file..." -ForegroundColor Yellow
    Start-Sleep 2
    notepad $downloadPath
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Evidence-Locker {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[EVIDENCE] Accessing FBI Evidence Locker Database..."
    Write-Host ""
    Start-Sleep 1
    Write-Host "[⚠️  RESTRICTED] Chain of Custody Required" -ForegroundColor Red
    Play-CriticalBeep
    Start-Sleep 1
    
    Show-ProgressBar -Activity "Authenticating access" -Color Red
    
    Write-Host ""
    
    $cases = @(
        @{
            ID="47291"
            Name="Drug Trafficking Operation"
            Evidence=@(
                "[EVIDENCE 001] 25kg Cocaine - Seized: 01/15/2024 - Location: Vault A",
                "[EVIDENCE 002] `$2.4M Cash - Seized: 01/15/2024 - Location: Vault B",
                "[EVIDENCE 003] Encrypted Phones (7) - Location: Tech Lab"
            )
        },
        @{
            ID="47294"
            Name="Terrorism Investigation"
            Evidence=@(
                "[EVIDENCE 001] Suspicious Documents - Location: Evidence Room 3",
                "[EVIDENCE 002] Computer Hard Drives (4) - Location: Cyber Lab",
                "[EVIDENCE 003] Weapons Cache - Location: Secure Vault C"
            )
        },
        @{
            ID="47296"
            Name="Securities Fraud"
            Evidence=@(
                "[EVIDENCE 001] Financial Records - Location: Document Archive",
                "[EVIDENCE 002] Server Backup (12TB) - Location: Digital Forensics",
                "[EVIDENCE 003] Email Communications - Location: Cloud Storage"
            )
        },
        @{
            ID="47300"
            Name="Bank Robbery"
            Evidence=@(
                "[EVIDENCE 001] Firearms (3) - Location: Ballistics Lab",
                "[EVIDENCE 002] Security Footage (HD) - Location: Media Room",
                "[EVIDENCE 003] DNA Samples - Location: Forensics Lab"
            )
        }
    )
    
    foreach ($case in $cases) {
        Write-Host "════════════════════════════════════════════════════════════════════"
        Write-Host "  CASE #$($case.ID) - $($case.Name)" -ForegroundColor Yellow
        Write-Host "════════════════════════════════════════════════════════════════════"
        
        foreach ($evidence in $case.Evidence) {
            Write-Host "  $evidence" -ForegroundColor White
            Play-Beep -frequency 700 -duration 40
            Start-Sleep -Milliseconds 300
        }
        
        Write-Host ""
    }
    
    Write-Host "[✓] 2,847 evidence items catalogued across 247 active cases" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Delete-System32 {
    Clear-WithTransition
    Play-CriticalBeep
    
    $host.ui.RawUI.ForegroundColor = "Red"
    
    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════════════════════════╗"
    Write-Host "  ║                                                                            ║"
    Write-Host "  ║                    ⚠️  WARNING: CRITICAL OPERATION  ⚠️                      ║"
    Write-Host "  ║                                                                            ║"
    Write-Host "  ║         This will permanently delete Windows System32 directory            ║"
    Write-Host "  ║                      System will become UNBOOTABLE                         ║"
    Write-Host "  ║                                                                            ║"
    Write-Host "  ║                  Press any key to continue or CTRL+C to abort...           ║"
    Write-Host "  ║                                                                            ║"
    Write-Host "  ╚════════════════════════════════════════════════════════════════════════════╝"
    Write-Host ""
    
    Play-CriticalBeep
    Read-Host "Press Enter to continue"
    
    if (Test-Detection) { return }
    
    Clear-WithTransition
    $host.ui.RawUI.ForegroundColor = "Green"
    
    Write-Slow "C:\Users\Admin> cd C:\Windows\System32"
    Write-Slow "C:\Windows\System32> takeown /f * /r /d y"
    Write-Host ""
    Start-Sleep 1
    Write-Host "[*] Taking ownership of protected system files..." -ForegroundColor Yellow
    Show-ProgressBar -Activity "Acquiring permissions" -Color Yellow
    Write-Host "[✓] Ownership acquired - 4,287 files" -ForegroundColor Green
    Play-Beep
    Write-Host ""
    
    Write-Slow "C:\Windows\System32> icacls * /grant administrators:F /t"
    Write-Host "[*] Granting full permissions..." -ForegroundColor Yellow
    Start-Sleep 1
    Write-Host "[✓] Permissions granted" -ForegroundColor Green
    Play-Beep
    Write-Host ""
    Write-Host ""
    
    $host.ui.RawUI.ForegroundColor = "Red"
    Write-Slow "C:\Windows\System32> del /f /s /q *.*"
    Write-Host ""
    Write-Host "════════════════════════════════════════════════════════════════════════════════"
    Write-Host "                          INITIATING DELETION SEQUENCE"
    Write-Host "════════════════════════════════════════════════════════════════════════════════"
    Write-Host ""
    Play-CriticalBeep
    Start-Sleep 1
    
    $files = @("kernel32.dll", "ntoskrnl.exe", "hal.dll", "ntdll.dll", "user32.dll", "gdi32.dll", "advapi32.dll", "shell32.dll", "ole32.dll", "oleaut32.dll", "msvcrt.dll", "wininet.dll", "comctl32.dll", "comdlg32.dll", "winspool.drv", "ws2_32.dll", "rpcrt4.dll", "imm32.dll", "imagehlp.dll", "psapi.dll", "version.dll", "winmm.dll", "netapi32.dll", "setupapi.dll", "shlwapi.dll", "crypt32.dll", "secur32.dll", "wintrust.dll", "userenv.dll", "uxtheme.dll", "dwmapi.dll", "dbghelp.dll", "winload.exe", "winresume.exe", "ntfs.sys", "disk.sys", "acpi.sys")
    
    foreach ($file in $files) {
        Write-Host "[DELETING] C:\Windows\System32\$file" -ForegroundColor Yellow
        Play-Beep -frequency (Get-Random -Minimum 400 -Maximum 1200) -duration 50
        Start-Sleep -Milliseconds 50
    }
    
    Write-Host ""
    Write-Host "[*] Wiping core OS components..." -ForegroundColor Red
    
    Show-ProgressBar -Activity "Removing protected objects" -Total 100 -Color Red
    
    Clear-WithTransition
    $host.ui.RawUI.BackgroundColor = "Red"
    $host.ui.RawUI.ForegroundColor = "White"
    Clear-Host
    
    Play-CriticalBeep
    
    Write-Host ""
    Write-Host ""
    Write-Host "     ███████╗ █████╗ ████████╗ █████╗ ██╗         ███████╗██████╗ ██████╗  ██████╗ ██████╗ "
    Write-Host "     ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║         ██╔════╝██╔══██╗██╔══██╗██╔═══██╗██╔══██╗"
    Write-Host "     █████╗  ███████║   ██║   ███████║██║         █████╗  ██████╔╝██████╔╝██║   ██║██████╔╝"
    Write-Host "     ██╔══╝  ██╔══██║   ██║   ██╔══██║██║         ██╔══╝  ██╔══██╗██╔══██╗██║   ██║██╔══██╗"
    Write-Host "     ██║     ██║  ██║   ██║   ██║  ██║███████╗    ███████╗██║  ██║██║  ██║╚██████╔╝██║  ██║"
    Write-Host "     ╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝"
    Write-Host ""
    Write-Host ""
    Start-Sleep 2
    Write-Host "              ╔═══════════════════════════════════════════════════════╗"
    Write-Host "              ║                                                       ║"
    Write-Host "              ║       SYSTEM32 DELETION COMPLETE                      ║"
    Write-Host "              ║       STATUS: UNBOOTABLE                              ║"
    Write-Host "              ║       FILES REMOVED: 4,287                            ║"
    Write-Host "              ║                                                       ║"
    Write-Host "              ║       Windows will not boot on next restart           ║"
    Write-Host "              ║                                                       ║"
    Write-Host "              ╚═══════════════════════════════════════════════════════╝"
    Write-Host ""
    Write-Host ""
    
    Play-CriticalBeep
    Start-Sleep 3
    
    $host.ui.RawUI.BackgroundColor = "Black"
    $host.ui.RawUI.ForegroundColor = "Green"
    Clear-Host
}

function Network-Attack {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[NETWORK] Scanning active connections..."
    Write-Host ""
    
    for ($i = 1; $i -le 20; $i++) {
        $ip = Get-RandomIP
        $port = Get-Random -Maximum 65535
        Write-Host "[CONN] $ip`:$port | STATUS: ESTABLISHED | ENCRYPTION: AES-256" -ForegroundColor Cyan
        Play-Beep -frequency (Get-Random -Minimum 600 -Maximum 1200) -duration 30
        Start-Sleep -Milliseconds 50
    }
    
    Write-Host ""
    Write-Slow "[EXPLOIT] Injecting payload..."
    Write-Host ""
    
    Show-ProgressBar -Activity "Uploading shellcode" -Color Red
    
    Write-Host ""
    Write-Host "[✓] Network infiltration successful - 20 systems compromised" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Crypto-Mine {
    Clear-WithTransition
    
    if (Test-Detection) { return }
    
    $host.ui.RawUI.ForegroundColor = "Yellow"
    Write-Slow "[CRYPTO] Initializing mining operation..."
    Write-Host ""
    Write-Slow "[*] Connecting to mining pool: btc-pool-elite.onion"
    Show-ProgressBar -Activity "Establishing Tor connection" -Color Yellow
    Write-Slow "[✓] Connected - Starting GPU threads"
    Play-Beep
    Write-Host ""
    
    for ($i = 1; $i -le 20; $i++) {
        $hash = Get-Random -Maximum 999999999
        $speed = (Get-Random -Maximum 500) + 100
        Write-Host "[MINING] Block #$i | Hash: 0x$hash | Speed: $speed MH/s" -ForegroundColor Yellow
        Play-Beep -frequency (800 + ($i * 10)) -duration 30
        Start-Sleep -Milliseconds 100
    }
    
    Write-Host ""
    Write-Slow "[✓] Mined 0.0047 BTC (`$287.43)"
    Play-SuccessBeep
    Write-Host ""
    $host.ui.RawUI.ForegroundColor = "Green"
    Read-Host "Press Enter to continue"
}

function Password-Crack {
    Clear-WithTransition
    Play-Beep
    
    if (Test-Detection) { return }
    
    Write-Slow "[PASSWORD CRACKER] Loading rainbow tables..."
    Show-ProgressBar -Activity "Loading 10GB wordlist" -Color Cyan
    Write-Host ""
    Write-Slow "[*] Target: admin@corporate.com"
    Write-Slow "[*] Hash: 5f4dcc3b5aa765d61d8327deb882cf99"
    Write-Host ""
    Write-Slow "[CRACKING] Attempting combinations..."
    Write-Host ""
    
    $attempts = @("password123", "admin123", "letmein", "welcome1", "qwerty123", "Password1", "Summer2024", "Corporate123", "Admin2024")
    
    foreach ($attempt in $attempts) {
        Write-Host "[TRYING] $attempt..." -ForegroundColor DarkGray
        Play-Beep -frequency (Get-Random -Minimum 400 -Maximum 800) -duration 50
        Start-Sleep -Milliseconds 200
    }
    
    Write-Host ""
    Write-Host "[✓] PASSWORD CRACKED: Admin2024" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

# ==================== SETTINGS ====================
function Show-Settings {
    Clear-WithTransition
    
    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "  ║                    SETTINGS & CONFIGURATION                ║" -ForegroundColor Cyan
    Write-Host "  ╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Current Settings:" -ForegroundColor Yellow
    Write-Host "  [1] Animation Speed: $($script:config.AnimationSpeed)ms" -ForegroundColor White
    Write-Host "  [2] Sound Effects: $($script:config.SoundEnabled)" -ForegroundColor White
    Write-Host "  [3] Matrix Speed: $($script:config.MatrixSpeed)ms" -ForegroundColor White
    Write-Host "  [4] Glitch Chance: $($script:config.GlitchChance * 100)%" -ForegroundColor White
    Write-Host "  [5] Detection Chance: $($script:config.DetectionChance * 100)%" -ForegroundColor White
    Write-Host "  [6] Return to Menu" -ForegroundColor White
    Write-Host ""
    
    $choice = Read-Host "Select setting to modify (1-6)"
    
    switch ($choice) {
        "1" {
            $speed = Read-Host "Enter animation speed in ms (10-200)"
            $script:config.AnimationSpeed = [int]$speed
            Write-Host "Animation speed updated!" -ForegroundColor Green
            Start-Sleep 1
            Show-Settings
        }
        "2" {
            $script:config.SoundEnabled = -not $script:config.SoundEnabled
            Write-Host "Sound effects: $($script:config.SoundEnabled)" -ForegroundColor Green
            Start-Sleep 1
            Show-Settings
        }
        "3" {
            $speed = Read-Host "Enter matrix speed in ms (10-100)"
            $script:config.MatrixSpeed = [int]$speed
            Write-Host "Matrix speed updated!" -ForegroundColor Green
            Start-Sleep 1
            Show-Settings
        }
        "4" {
            $chance = Read-Host "Enter glitch chance 0-100 (%)"
            $script:config.GlitchChance = [double]$chance / 100
            Write-Host "Glitch chance updated!" -ForegroundColor Green
            Start-Sleep 1
            Show-Settings
        }
        "5" {
            $chance = Read-Host "Enter detection chance 0-100 (%)"
            $script:config.DetectionChance = [double]$chance / 100
            Write-Host "Detection chance updated!" -ForegroundColor Green
            Start-Sleep 1
            Show-Settings
        }
        "6" { return }
    }
}

# ==================== MAIN LOOP ====================
$host.ui.RawUI.WindowTitle = "FBI TERMINAL"
$host.ui.RawUI.BackgroundColor = "Black"
$host.ui.RawUI.ForegroundColor = "Green"
Clear-Host

do {
    Show-Menu
    $choice = Read-Host "root@terminal:~#"
    
    try {
        switch ($choice) {
            "1"  { FBI-Hack-Start }
            "2"  { Delete-System32 }
            "3"  { Network-Attack }
            "4"  { Crypto-Mine }
            "5"  { Password-Crack }
            "6"  { Track-Suspects }
            "7"  { Agent-Profiles }
            "8"  { Satellite-Uplink }
            "9"  { Download-Files }
            "10" { Start-SQLInjection }
            "11" { Start-DDoSAttack }
            "12" { Start-Ransomware }
            "13" { Start-Keylogger }
            "14" { Start-WiFiCracker }
            "15" { Start-PhishingCampaign }
            "16" { Show-SystemInfo }
            "17" { Show-Settings }
            "18" { 
                Clear-WithTransition
                Write-Host "Exiting..." -ForegroundColor Red
                Play-ErrorBeep
                Start-Sleep 1
                exit 
            }
            default {
                Write-Host "Invalid option!" -ForegroundColor Red
                Play-ErrorBeep
                Start-Sleep 1
            }
        }
    }
    catch {
        Write-Host "Error occurred: $_" -ForegroundColor Red
        Play-ErrorBeep
        Start-Sleep 2
    }
    
} while ($true)
