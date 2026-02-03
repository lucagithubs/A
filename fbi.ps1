# ==================== ENHANCED ORIGINAL FUNCTIONS ====================

function FBI-Hack-Start {
    Clear-WithTransition
    Play-Beep -frequency 800 -duration 150
    
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
        Write-Host "     │      ║░███░███░║         │" -ForegroundColor Green
        Play-Beep -frequency 1000 -duration 50
        Start-Sleep -Milliseconds 300
        Write-Host "`r     │      ║ ░░░░░░░║         │" -ForegroundColor DarkGray -NoNewline
        Start-Sleep -Milliseconds 300
    }
    
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
    
    # Retinal scan animation with progressive beeps
    for ($i = 0; $i -lt 5; $i++) {
        Play-Beep -frequency (1000 + ($i * 100)) -duration 50
        Start-Sleep -Milliseconds 200
    }
    
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
        Play-Beep -frequency 700 -duration 60
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
        Play-Beep -frequency 950 -duration 50
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
    Play-Beep -frequency 850 -duration 100
    
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
        
        Play-Beep -frequency 850 -duration 60
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
    Play-Beep -frequency 800 -duration 100
    
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
        
        Play-Beep -frequency (650 + ($i * 15)) -duration 40
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
    Play-Beep -frequency 900 -duration 100
    
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
        Play-Beep -frequency 750 -duration 50
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
    Play-Beep -frequency 950 -duration 100
    
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
        Play-Beep -frequency 950 -duration 60
    }
    
    Write-Host ""
    Write-Host "[✓] 7 TOP SECRET documents downloaded (1.03 GB total)" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Surveillance-Footage {
    Clear-WithTransition
    Play-Beep -frequency 1000 -duration 100
    
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
        Play-Beep -frequency 1050 -duration 40
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
        Play-Beep -frequency 650 -duration 80
    }
    
    Write-Host ""
    Write-Host "[✓] 127 surveillance feeds accessed | 45 wiretaps downloaded" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Witness-Protection {
    Clear-WithTransition
    Play-Beep -frequency 700 -duration 100
    
    if (Test-Detection) { return }
    
    Write-Slow "[DATABASE] Accessing Witness Protection Program..."
    Write-Host ""
    Write-Host "[⚠️  WARNING] This database contains HIGHLY SENSITIVE information" -ForegroundColor Red
    Play-WarningBeep
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
        Play-Beep -frequency 550 -duration 50
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
    Play-Beep -frequency 1100 -duration 100
    
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
        Play-Beep -frequency 1150 -duration 80
        Start-Sleep 1
    }
    
    Write-Host "[✓] 3,847 agent profiles accessed" -ForegroundColor Red
    Play-SuccessBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

function Satellite-Uplink {
    Clear-WithTransition
    Play-Beep -frequency 1200 -duration 100
    
    if (Test-Detection) { return }
    
    Write-Slow "[SATELLITE] Establishing connection to surveillance satellites..."
    Write-Host ""
    Start-Sleep 1
    Write-Host "[*] Connecting to KEYHOLE-12 satellite network..." -ForegroundColor Yellow
    Show-ProgressBar -Activity "Establishing uplink" -Color Cyan
    
    Write-Host "[*] Authentication: ACCEPTED" -ForegroundColor Green
    Play-Beep -frequency 1250 -duration 100
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
        Play-Beep -frequency 950 -duration 60
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
    Play-Beep -frequency 1000 -duration 100
    
    if (Test-Detection) { return }
    
    Write-Slow "[WEBCAM] Accessing remote webcam feeds..."
    Write-Host ""
    Start-Sleep 1
    Write-Host "[⚠️  WARNING] Unauthorized access to private devices" -ForegroundColor Red
    Play-WarningBeep
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
        Play-Beep -frequency 1050 -duration 50
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
    Play-Beep -frequency 900 -duration 100
    
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
    Play-Beep -frequency 800 -duration 100
    
    if (Test-Detection) { return }
    
    Write-Slow "[EVIDENCE] Accessing FBI Evidence Locker Database..."
    Write-Host ""
    Start-Sleep 1
    Write-Host "[⚠️  RESTRICTED] Chain of Custody Required" -ForegroundColor Red
    Play-WarningBeep
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
            Play-Beep -frequency 750 -duration 50
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
    Play-WarningBeep
    
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
    
    Play-WarningBeep
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
    Play-SuccessBeep
    Write-Host ""
    
    Write-Slow "C:\Windows\System32> icacls * /grant administrators:F /t"
    Write-Host "[*] Granting full permissions..." -ForegroundColor Yellow
    Start-Sleep 1
    Write-Host "[✓] Permissions granted" -ForegroundColor Green
    Play-SuccessBeep
    Write-Host ""
    Write-Host ""
    
    $host.ui.RawUI.ForegroundColor = "Red"
    Write-Slow "C:\Windows\System32> del /f /s /q *.*"
    Write-Host ""
    Write-Host "════════════════════════════════════════════════════════════════════════════════"
    Write-Host "                          INITIATING DELETION SEQUENCE"
    Write-Host "════════════════════════════════════════════════════════════════════════════════"
    Write-Host ""
    Play-WarningBeep
    Start-Sleep 1
    
    $files = @("kernel32.dll", "ntoskrnl.exe", "hal.dll", "ntdll.dll", "user32.dll", "gdi32.dll", "advapi32.dll", "shell32.dll", "ole32.dll", "oleaut32.dll", "msvcrt.dll", "wininet.dll", "comctl32.dll", "comdlg32.dll", "winspool.drv", "ws2_32.dll", "rpcrt4.dll", "imm32.dll", "imagehlp.dll", "psapi.dll", "version.dll", "winmm.dll", "netapi32.dll", "setupapi.dll", "shlwapi.dll", "crypt32.dll", "secur32.dll", "wintrust.dll", "userenv.dll", "uxtheme.dll", "dwmapi.dll", "dbghelp.dll", "winload.exe", "winresume.exe", "ntfs.sys", "disk.sys", "acpi.sys")
    
    foreach ($file in $files) {
        Write-Host "[DELETING] C:\Windows\System32\$file" -ForegroundColor Yellow
        Play-Beep -frequency (Get-Random -Minimum 400 -Maximum 1400) -duration 60
        Start-Sleep -Milliseconds 50
    }
    
    Write-Host ""
    Write-Host "[*] Wiping core OS components..." -ForegroundColor Red
    
    Show-ProgressBar -Activity "Removing protected objects" -Total 100 -Color Red
    
    Clear-WithTransition
    $host.ui.RawUI.BackgroundColor = "Red"
    $host.ui.RawUI.ForegroundColor = "White"
    Clear-Host
    
    Play-WarningBeep
    
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
    
    Play-WarningBeep
    Start-Sleep 3
    
    $host.ui.RawUI.BackgroundColor = "Black"
    $host.ui.RawUI.ForegroundColor = "Green"
    Clear-Host
}

function Network-Attack {
    Clear-WithTransition
    Play-Beep -frequency 850 -duration 100
    
    if (Test-Detection) { return }
    
    Write-Slow "[NETWORK] Scanning active connections..."
    Write-Host ""
    
    for ($i = 1; $i -le 20; $i++) {
        $ip = Get-RandomIP
        $port = Get-Random -Maximum 65535
        Write-Host "[CONN] $ip`:$port | STATUS: ESTABLISHED | ENCRYPTION: AES-256" -ForegroundColor Cyan
        Play-Beep -frequency (700 + ($i * 20)) -duration 40
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
    Play-SuccessBeep
    Write-Host ""
    
    for ($i = 1; $i -le 20; $i++) {
        $hash = Get-Random -Maximum 999999999
        $speed = (Get-Random -Maximum 500) + 100
        Write-Host "[MINING] Block #$i | Hash: 0x$hash | Speed: $speed MH/s" -ForegroundColor Yellow
        Play-Beep -frequency (850 + ($i * 10)) -duration 40
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
    Play-Beep -frequency 900 -duration 100
    
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
        Play-Beep -frequency (Get-Random -Minimum 500 -Maximum 900) -duration 50
        Start-Sleep -Milliseconds 200
    }
    
    Write-Host ""
    Write-Host "[✓] PASSWORD CRACKED: Admin2024" -ForegroundColor Red
    Play-CriticalBeep
    Write-Host ""
    Read-Host "Press Enter to continue"
}

# ==================== SETTINGS (HIDDEN OPTIONS REMOVED) ====================
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
    Write-Host "  [4] Return to Menu" -ForegroundColor White
    Write-Host ""
    
    $choice = Read-Host "Select setting to modify (1-4)"
    
    switch ($choice) {
        "1" {
            $speed = Read-Host "Enter animation speed in ms (10-200)"
            $script:config.AnimationSpeed = [int]$speed
            Write-Host "Animation speed updated!" -ForegroundColor Green
            Play-SuccessBeep
            Start-Sleep 1
            Show-Settings
        }
        "2" {
            $script:config.SoundEnabled = -not $script:config.SoundEnabled
            Write-Host "Sound effects: $($script:config.SoundEnabled)" -ForegroundColor Green
            if ($script:config.SoundEnabled) { Play-SuccessBeep }
            Start-Sleep 1
            Show-Settings
        }
        "3" {
            $speed = Read-Host "Enter matrix speed in ms (10-100)"
            $script:config.MatrixSpeed = [int]$speed
            Write-Host "Matrix speed updated!" -ForegroundColor Green
            Play-SuccessBeep
            Start-Sleep 1
            Show-Settings
        }
        "4" { return }
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
