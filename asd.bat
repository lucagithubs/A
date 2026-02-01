@echo off
color 0a
mode con cols=120 lines=40
setlocal enabledelayedexpansion

:menu
cls
color 0c
echo.
echo     ███████╗██████╗ ██╗    ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗     
echo     ██╔════╝██╔══██╗██║    ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║     
echo     █████╗  ██████╔╝██║       ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║     
echo     ██╔══╝  ██╔══██╗██║       ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║     
echo     ██║     ██████╔╝██║       ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗
echo     ╚═╝     ╚═════╝ ╚═╝       ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
echo.
color 0a
echo                          ╔═════════════════════════════════════════╗
echo                          ║   CLASSIFIED ACCESS SYSTEM v4.7.2      ║
echo                          ╚═════════════════════════════════════════╝
echo.
echo.
echo                              ┌─────────────────────────────┐
echo                              │    SELECT OPERATION:        │
echo                              ├─────────────────────────────┤
echo                              │                             │
echo                              │  [1] FBI Database Hack      │
echo                              │  [2] Delete System32        │
echo                              │  [3] Network Infiltration   │
echo                              │  [4] Crypto Mining Attack   │
echo                              │  [5] Password Cracker       │
echo                              │  [6] Exit                   │
echo                              │                             │
echo                              └─────────────────────────────┘
echo.
echo.
set /p choice="                              root@terminal:~# "

if "%choice%"=="1" goto fbi_hack_start
if "%choice%"=="2" goto delete_system32
if "%choice%"=="3" goto network_attack
if "%choice%"=="4" goto crypto_mine
if "%choice%"=="5" goto password_crack
if "%choice%"=="6" exit
goto menu

:fbi_hack_start
cls
color 0a
echo.
echo  ███████╗██████╗ ██╗    ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
echo  ██╔════╝██╔══██╗██║    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
echo  █████╗  ██████╔╝██║    ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗  
echo  ██╔══╝  ██╔══██╗██║    ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝  
echo  ██║     ██████╔╝██║    ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
echo  ╚═╝     ╚═════╝ ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
echo.
echo                        [CLASSIFIED - TOP SECRET - EYES ONLY]
echo.
timeout /t 1 /nobreak >nul

:: PHASE 1: Biometric Scan
call :type "[PHASE 1/6] Biometric Authentication Required"
echo.
call :type "Place finger on scanner..."
timeout /t 1 /nobreak >nul
echo.
echo     ┌─────────────────────────┐
echo     │   FINGERPRINT SCANNER   │
echo     │                         │
echo     │       ╔═══════╗         │
echo     │      ║ ░░░░░░░║         │
echo     │      ║░███░███░║         │
echo     │      ║░░█████░░║         │
echo     │      ║░██░█░██░║         │
echo     │       ╚═══════╝         │
echo     │                         │
echo     │   SCANNING...           │
echo     └─────────────────────────┘
timeout /t 2 /nobreak >nul
cls
echo.
echo  ███████╗██████╗ ██╗    ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
echo  ██╔════╝██╔══██╗██║    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
echo  █████╗  ██████╔╝██║    ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗  
echo  ██╔══╝  ██╔══██╗██║    ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝  
echo  ██║     ██████╔╝██║    ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
echo  ╚═╝     ╚═════╝ ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
echo.
echo.
echo     ┌─────────────────────────┐
echo     │   RETINAL SCANNER       │
echo     │                         │
echo     │         ▓▓▓▓▓           │
echo     │       ▓▓░░░░░▓▓         │
echo     │      ▓░░░██░░░▓         │
echo     │      ▓░░░██░░░▓         │
echo     │       ▓▓░░░░░▓▓         │
echo     │         ▓▓▓▓▓           │
echo     │                         │
echo     │   SCANNING RETINA...    │
echo     └─────────────────────────┘
timeout /t 2 /nobreak >nul
echo.
color 0c
call :type "[✓] BIOMETRIC MATCH - Director Level Clearance"
color 0a
echo.
timeout /t 1 /nobreak >nul

:: PHASE 2: Connection
cls
call :type "[PHASE 2/6] Initiating secure connection to FBI mainframe..."
echo.
call :type "Connecting to: fbi-sentinel.gov (192.168.254.100:8443)"
timeout /t 1 /nobreak >nul
echo [*] Establishing encrypted tunnel...
timeout /t 1 /nobreak >nul
echo [*] SSL/TLS Handshake... OK
timeout /t 0 /nobreak >nul
echo [*] Certificate validation... OK
timeout /t 1 /nobreak >nul
color 0c
echo [✓] SECURE CONNECTION ESTABLISHED
color 0a
echo.
timeout /t 1 /nobreak >nul

:: PHASE 3: Authentication Bypass
call :type "[PHASE 3/6] Bypassing multi-factor authentication..."
echo.
echo [*] Intercepting 2FA token...
timeout /t 1 /nobreak >nul
echo [*] Token captured: 847291
timeout /t 0 /nobreak >nul
echo [*] Replaying authentication sequence...
timeout /t 1 /nobreak >nul
color 0c
echo [✓] 2FA BYPASSED
color 0a
echo.
timeout /t 1 /nobreak >nul

:: PHASE 4: Security Disable
call :type "[PHASE 4/6] Disabling security systems..."
echo.
echo [*] Killing firewall processes... DONE
timeout /t 0 /nobreak >nul
echo [*] Disabling IDS/IPS monitoring... DONE
timeout /t 0 /nobreak >nul
echo [*] Stopping antivirus services... DONE
timeout /t 0 /nobreak >nul
echo [*] Erasing access logs... DONE
timeout /t 1 /nobreak >nul
color 0c
echo [✓] ALL SECURITY SYSTEMS DISABLED
color 0a
echo.
timeout /t 1 /nobreak >nul

:: PHASE 5: Backdoor Installation
call :type "[PHASE 5/6] Installing persistent backdoor..."
echo.
echo [*] Uploading payload... ████████████████ 100%%
timeout /t 1 /nobreak >nul
echo [*] Configuring autostart... DONE
timeout /t 0 /nobreak >nul
echo [*] Hiding process from task manager... DONE
timeout /t 1 /nobreak >nul
color 0c
echo [✓] BACKDOOR INSTALLED - PERSISTENT ACCESS GRANTED
color 0a
echo.
timeout /t 1 /nobreak >nul

:: PHASE 6: Database Access
call :type "[PHASE 6/6] Accessing SENTINEL database..."
echo.
timeout /t 2 /nobreak >nul
color 0c
echo [✓✓✓] FULL SYSTEM ACCESS GRANTED [✓✓✓]
color 0a
echo.
timeout /t 1 /nobreak >nul
pause

:fbi_menu
cls
color 0a
echo.
echo  ███████╗███████╗███╗   ██╗████████╗██╗███╗   ██╗███████╗██╗         
echo  ██╔════╝██╔════╝████╗  ██║╚══██╔══╝██║████╗  ██║██╔════╝██║         
echo  ███████╗█████╗  ██╔██╗ ██║   ██║   ██║██╔██╗ ██║█████╗  ██║         
echo  ╚════██║██╔══╝  ██║╚██╗██║   ██║   ██║██║╚██╗██║██╔══╝  ██║         
echo  ███████║███████╗██║ ╚████║   ██║   ██║██║ ╚████║███████╗███████╗    
echo  ╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝    
echo.
echo                        FBI DATABASE ACCESS SYSTEM
echo ════════════════════════════════════════════════════════════════════════
echo.
echo     [1] Track Suspects (GPS)          [7] Agent Profiles
echo     [2] Criminal Records               [8] Satellite Uplink
echo     [3] Active Investigations          [9] Webcam Access
echo     [4] Classified Documents          [10] Download Files
echo     [5] Surveillance Footage          [11] Evidence Locker
echo     [6] Witness Protection            [12] Back to Main Menu
echo.
echo ════════════════════════════════════════════════════════════════════════
set /p fbichoice="SELECT DATABASE: "

if "%fbichoice%"=="1" goto track_suspects
if "%fbichoice%"=="2" goto fbi_criminal
if "%fbichoice%"=="3" goto fbi_investigations
if "%fbichoice%"=="4" goto fbi_documents
if "%fbichoice%"=="5" goto fbi_surveillance
if "%fbichoice%"=="6" goto fbi_witness
if "%fbichoice%"=="7" goto agent_profiles
if "%fbichoice%"=="8" goto satellite
if "%fbichoice%"=="9" goto webcam_access
if "%fbichoice%"=="10" goto file_download
if "%fbichoice%"=="11" goto evidence_locker
if "%fbichoice%"=="12" goto menu
goto fbi_menu

:track_suspects
cls
color 0a
call :type "[GPS TRACKING] Accessing real-time suspect locations..."
echo.
timeout /t 1 /nobreak >nul
echo ┌────────────────────────────────────────────────────────────────────┐
echo │                    ACTIVE SUSPECT TRACKING                         │
echo ├────────────────────────────────────────────────────────────────────┤
echo │                                                                    │
timeout /t 0 /nobreak >nul
set /a "lat1=40 + !random! %% 10"
set /a "lon1=-74 - !random! %% 10"
echo │  [SUSPECT #1847] John Martinez                                     │
echo │  Status: ARMED AND DANGEROUS                                       │
echo │  Location: !lat1!.!random:~-4!°N, !lon1!.!random:~-4!°W                                  │
echo │  Address: 742 Broadway St, New York, NY                            │
echo │  Speed: 45 MPH - Moving North                                      │
echo │  Last Update: 3 seconds ago                                        │
echo │                                                                    │
timeout /t 1 /nobreak >nul
set /a "lat2=34 + !random! %% 10"
set /a "lon2=-118 - !random! %% 10"
echo │  [SUSPECT #2891] Sarah Chen                                        │
echo │  Status: WANTED - CYBER CRIMES                                     │
echo │  Location: !lat2!.!random:~-4!°N, !lon2!.!random:~-4!°W                                 │
echo │  Address: 1523 Sunset Blvd, Los Angeles, CA                        │
echo │  Speed: STATIONARY                                                 │
echo │  Last Update: 1 second ago                                         │
echo │                                                                    │
timeout /t 1 /nobreak >nul
set /a "lat3=41 + !random! %% 10"
set /a "lon3=-87 - !random! %% 10"
echo │  [SUSPECT #3247] Michael Torres                                    │
echo │  Status: FUGITIVE - DO NOT APPROACH                                │
echo │  Location: !lat3!.!random:~-4!°N, !lon3!.!random:~-4!°W                                 │
echo │  Address: 891 Michigan Ave, Chicago, IL                            │
echo │  Speed: 67 MPH - Moving East                                       │
echo │  Last Update: 5 seconds ago                                        │
echo │                                                                    │
echo └────────────────────────────────────────────────────────────────────┘
echo.
color 0c
call :type "[✓] 47 suspects being tracked in real-time"
color 0a
echo.
pause
goto fbi_menu

:fbi_criminal
cls
color 0a
call :type "[DATABASE] Accessing criminal records..."
echo.
for /L %%i in (1,1,15) do (
    call :database
)
echo.
color 0c
call :type "[✓] Downloaded 15,847 criminal records"
color 0a
echo.
pause
goto fbi_menu

:fbi_investigations
cls
color 0a
call :type "[DATABASE] Retrieving active investigations..."
echo.
echo [CASE #47291] Operation Dark Web - Drug Trafficking - Status: ACTIVE
timeout /t 0 /nobreak >nul
echo [CASE #47292] Cyber Espionage - Foreign Interference - Status: CLASSIFIED
timeout /t 0 /nobreak >nul
echo [CASE #47293] Money Laundering - Organized Crime - Status: ACTIVE
timeout /t 0 /nobreak >nul
echo [CASE #47294] Terrorism Investigation - Threat Level: HIGH
timeout /t 0 /nobreak >nul
echo [CASE #47295] Kidnapping - Amber Alert - Status: URGENT
timeout /t 0 /nobreak >nul
echo [CASE #47296] White Collar Crime - Securities Fraud - Status: ACTIVE
timeout /t 0 /nobreak >nul
echo [CASE #47297] Human Trafficking - Multi-State - Status: CLASSIFIED
timeout /t 0 /nobreak >nul
echo [CASE #47298] Arson Investigation - Federal Property - Status: ACTIVE
timeout /t 0 /nobreak >nul
echo [CASE #47299] Political Corruption - Congress Member - Status: TOP SECRET
timeout /t 0 /nobreak >nul
echo [CASE #47300] Bank Robbery - Armed Suspects - Status: MANHUNT
timeout /t 0 /nobreak >nul
echo.
color 0c
call :type "[✓] 247 active investigations retrieved"
color 0a
echo.
pause
goto fbi_menu

:fbi_documents
cls
color 0a
call :type "[DATABASE] Downloading classified documents..."
echo.
echo [DOWNLOADING] PROJECT_SENTINEL.pdf (127 MB) ████████████████ 100%%
timeout /t 0 /nobreak >nul
echo [DOWNLOADING] OPERATION_BLACKOUT.docx (43 MB) ████████████████ 100%%
timeout /t 0 /nobreak >nul
echo [DOWNLOADING] WITNESS_LIST_2024.xlsx (89 MB) ████████████████ 100%%
timeout /t 0 /nobreak >nul
echo [DOWNLOADING] SURVEILLANCE_PROTOCOLS.pdf (156 MB) ████████████████ 100%%
timeout /t 0 /nobreak >nul
echo [DOWNLOADING] ASSET_SEIZURE_RECORDS.pdf (201 MB) ████████████████ 100%%
timeout /t 0 /nobreak >nul
echo [DOWNLOADING] UNDERCOVER_AGENTS.xlsx (73 MB) ████████████████ 100%%
timeout /t 0 /nobreak >nul
echo [DOWNLOADING] INFORMANT_DATABASE.db (341 MB) ████████████████ 100%%
timeout /t 0 /nobreak >nul
echo.
color 0c
call :type "[✓] 7 TOP SECRET documents downloaded (1.03 GB total)"
color 0a
echo.
pause
goto fbi_menu

:fbi_surveillance
cls
color 0a
call :type "[SURVEILLANCE] Accessing security camera feeds..."
echo.
echo [CAMERA 001] NYC - Times Square - ACTIVE - Recording
timeout /t 0 /nobreak >nul
echo [CAMERA 002] LA - Federal Building - ACTIVE - Recording
timeout /t 0 /nobreak >nul
echo [CAMERA 003] Chicago - O'Hare Airport - ACTIVE - Recording
timeout /t 0 /nobreak >nul
echo [CAMERA 004] Miami - Port Authority - ACTIVE - Recording
timeout /t 0 /nobreak >nul
echo [CAMERA 005] DC - Capitol Building - ACTIVE - Recording
timeout /t 0 /nobreak >nul
echo [CAMERA 006] Houston - FBI Field Office - ACTIVE - Recording
timeout /t 0 /nobreak >nul
echo [CAMERA 007] Phoenix - Border Checkpoint - ACTIVE - Recording
timeout /t 0 /nobreak >nul
echo.
call :type "[AUDIO] Accessing wiretap recordings..."
echo.
echo [WIRETAP 891] Target: John Martinez - Duration: 47:23 - DOWNLOADING...
timeout /t 1 /nobreak >nul
echo [WIRETAP 892] Target: Sarah Chen - Duration: 31:56 - DOWNLOADING...
timeout /t 1 /nobreak >nul
echo [WIRETAP 893] Target: Unknown - Duration: 1:14:09 - DOWNLOADING...
timeout /t 1 /nobreak >nul
echo.
color 0c
call :type "[✓] 127 surveillance feeds accessed | 45 wiretaps downloaded"
color 0a
echo.
pause
goto fbi_menu

:fbi_witness
cls
color 0a
call :type "[DATABASE] Accessing Witness Protection Program..."
echo.
color 0c
echo [⚠️  WARNING] This database contains HIGHLY SENSITIVE information
color 0a
timeout /t 1 /nobreak >nul
echo.
echo [WITNESS ID: WP-2891] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED
timeout /t 0 /nobreak >nul
echo [WITNESS ID: WP-2892] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED
timeout /t 0 /nobreak >nul
echo [WITNESS ID: WP-2893] Name: [REDACTED] - Location: [REDACTED] - Status: RELOCATED
timeout /t 0 /nobreak >nul
echo [WITNESS ID: WP-2894] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED
timeout /t 0 /nobreak >nul
echo [WITNESS ID: WP-2895] Name: [REDACTED] - Location: [REDACTED] - Status: COMPROMISED
timeout /t 0 /nobreak >nul
echo [WITNESS ID: WP-2896] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED
timeout /t 0 /nobreak >nul
echo [WITNESS ID: WP-2897] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED
timeout /t 0 /nobreak >nul
echo.
color 0c
call :type "[✓] 1,247 witness records accessed"
color 0a
echo.
pause
goto fbi_menu

:agent_profiles
cls
color 0a
call :type "[DATABASE] Accessing FBI Agent Profiles..."
echo.
timeout /t 1 /nobreak >nul
echo ════════════════════════════════════════════════════════════════════
echo  AGENT PROFILE #001
echo ════════════════════════════════════════════════════════════════════
echo  Name: Special Agent James Rodriguez
echo  Badge: SA-47291
echo  Division: Cyber Crimes
echo  Clearance: Level 5 - Top Secret
echo  Location: Washington D.C. Field Office
echo  Status: ACTIVE - Currently on assignment
echo  Cases: 47 closed | 12 active
echo ════════════════════════════════════════════════════════════════════
timeout /t 1 /nobreak >nul
echo.
echo ════════════════════════════════════════════════════════════════════
echo  AGENT PROFILE #002
echo ════════════════════════════════════════════════════════════════════
echo  Name: Special Agent Emily Carter
echo  Badge: SA-39182
echo  Division: Counter-Terrorism
echo  Clearance: Level 6 - Classified
echo  Location: New York Field Office
echo  Status: ACTIVE - Undercover operation
echo  Cases: 89 closed | 8 active
echo ════════════════════════════════════════════════════════════════════
timeout /t 1 /nobreak >nul
echo.
echo ════════════════════════════════════════════════════════════════════
echo  AGENT PROFILE #003
echo ════════════════════════════════════════════════════════════════════
echo  Name: Special Agent Michael Chen
echo  Badge: SA-51847
echo  Division: Organized Crime
echo  Clearance: Level 5 - Top Secret
echo  Location: Los Angeles Field Office
echo  Status: ACTIVE - Field assignment
echo  Cases: 62 closed | 15 active
echo ════════════════════════════════════════════════════════════════════
echo.
color 0c
call :type "[✓] 3,847 agent profiles accessed"
color 0a
echo.
pause
goto fbi_menu

:satellite
cls
color 0a
call :type "[SATELLITE] Establishing connection to surveillance satellites..."
echo.
timeout /t 1 /nobreak >nul
echo [*] Connecting to KEYHOLE-12 satellite network...
timeout /t 1 /nobreak >nul
echo [*] Authentication: ACCEPTED
timeout /t 0 /nobreak >nul
echo [*] Uplink established
timeout /t 1 /nobreak >nul
color 0c
echo [✓] SATELLITE CONNECTION ACTIVE
color 0a
echo.
timeout /t 1 /nobreak >nul
echo ┌────────────────────────────────────────────────────────────────┐
echo │                  ACTIVE SATELLITES                             │
echo ├────────────────────────────────────────────────────────────────┤
echo │                                                                │
echo │  [SAT-01] KEYHOLE-12A   - Orbit: 380km - Status: OPERATIONAL   │
echo │  [SAT-02] KEYHOLE-12B   - Orbit: 385km - Status: OPERATIONAL   │
echo │  [SAT-03] LACROSSE-5    - Orbit: 680km - Status: OPERATIONAL   │
echo │  [SAT-04] MERCURY-7     - Orbit: 420km - Status: OPERATIONAL   │
echo │                                                                │
echo └────────────────────────────────────────────────────────────────┘
echo.
call :type "[SATELLITE] Accessing real-time imaging..."
echo.
echo [IMAGE 001] Target: 40.7128°N, 74.0060°W (NYC) - Resolution: 0.3m
timeout /t 0 /nobreak >nul
echo [IMAGE 002] Target: 34.0522°N, 118.2437°W (LA) - Resolution: 0.3m
timeout /t 0 /nobreak >nul
echo [IMAGE 003] Target: 41.8781°N, 87.6298°W (Chicago) - Resolution: 0.3m
timeout /t 0 /nobreak >nul
echo.
call :type "[SATELLITE] Tracking mobile targets..."
echo.
echo [TRACKING] Vehicle plate: ABC-1234 - Last seen: 5 minutes ago
timeout /t 0 /nobreak >nul
echo [TRACKING] Suspect: John Martinez - Current location acquired
timeout /t 0 /nobreak >nul
echo.
color 0c
call :type "[✓] 4 satellites online | Real-time tracking active"
color 0a
echo.
pause
goto fbi_menu

:webcam_access
cls
color 0a
call :type "[WEBCAM] Accessing remote webcam feeds..."
echo.
timeout /t 1 /nobreak >nul
color 0c
echo [⚠️  WARNING] Unauthorized access to private devices
color 0a
timeout /t 1 /nobreak >nul
echo.
echo [WEBCAM 001] IP: 192.168.1.47 - Location: New York, NY - ACTIVE
timeout /t 0 /nobreak >nul
echo [WEBCAM 002] IP: 10.0.0.158 - Location: Los Angeles, CA - ACTIVE
timeout /t 0 /nobreak >nul
echo [WEBCAM 003] IP: 172.16.0.92 - Location: Chicago, IL - ACTIVE
timeout /t 0 /nobreak >nul
echo [WEBCAM 004] IP: 192.168.0.201 - Location: Houston, TX - ACTIVE
timeout /t 0 /nobreak >nul
echo [WEBCAM 005] IP: 10.1.1.88 - Location: Phoenix, AZ - ACTIVE
timeout /t 0 /nobreak >nul
echo [WEBCAM 006] IP: 172.20.0.156 - Location: Miami, FL - ACTIVE
timeout /t 0 /nobreak >nul
echo.
call :type "[RECORDING] Starting video capture..."
echo.
for /L %%i in (1,1,10) do (
    set /a "prog=%%i * 10"
    echo [████████░░░░░░░░] !prog!%% - Recording footage...
    timeout /t 0 /nobreak >nul
)
echo.
call :type "[AUDIO] Accessing microphone feeds..."
echo.
echo [MIC 001] Device detected - Recording audio... ACTIVE
timeout /t 0 /nobreak >nul
echo [MIC 002] Device detected - Recording audio... ACTIVE
timeout /t 0 /nobreak >nul
echo [MIC 003] Device detected - Recording audio... ACTIVE
timeout /t 0 /nobreak >nul
echo.
color 0c
call :type "[✓] 47 webcams accessed | 32 audio feeds active"
color 0a
echo.
pause
goto fbi_menu

:file_download
cls
color 0a
call :type "[FILE TRANSFER] Downloading classified files to local system..."
echo.
timeout /t 1 /nobreak >nul

:: Create the fake download in Downloads folder
set "downloadPath=%USERPROFILE%\Downloads\FBI_CLASSIFIED_DATA.txt"
echo ════════════════════════════════════════════════════════════ > "%downloadPath%"
echo  FBI CLASSIFIED DATABASE EXTRACT >> "%downloadPath%"
echo  ACCESS LEVEL: TOP SECRET >> "%downloadPath%"
echo  EXTRACTED: %date% %time% >> "%downloadPath%"
echo ════════════════════════════════════════════════════════════ >> "%downloadPath%"
echo. >> "%downloadPath%"
echo  Ha! You thought you actually hacked the FBI, didn't you? >> "%downloadPath%"
echo. >> "%downloadPath%"
echo  This is just a harmless batch script for fun. >> "%downloadPath%"
echo  No real data was accessed or downloaded. >> "%downloadPath%"
echo  No systems were harmed. >> "%downloadPath%"
echo. >> "%downloadPath%"
echo  Hope you enjoyed the show! ;) >> "%downloadPath%"
echo. >> "%downloadPath%"
echo ════════════════════════════════════════════════════════════ >> "%downloadPath%"

echo [DOWNLOADING] FBI_CLASSIFIED_DATA.txt
echo.
for /L %%i in (1,1,20) do (
    set /a "prog=%%i * 5"
    echo [████████████████░░░░] !prog!%% - Transferring encrypted data...
    timeout /t 0 /nobreak >nul
)
echo.
color 0c
call :type "[✓] File downloaded to: %USERPROFILE%\Downloads\FBI_CLASSIFIED_DATA.txt"
color 0a
echo.
echo Opening file...
timeout /t 2 /nobreak >nul
start notepad "%downloadPath%"
echo.
pause
goto fbi_menu

:evidence_locker
cls
color 0a
call :type "[EVIDENCE] Accessing FBI Evidence Locker Database..."
echo.
timeout /t 1 /nobreak >nul
color 0c
echo [⚠️  RESTRICTED] Chain of Custody Required
color 0a
timeout /t 1 /nobreak >nul
echo.
echo ════════════════════════════════════════════════════════════════════
echo  CASE #47291 - Drug Trafficking Operation
echo ════════════════════════════════════════════════════════════════════
echo  [EVIDENCE 001] 25kg Cocaine - Seized: 01/15/2024 - Location: Vault A
echo  [EVIDENCE 002] $2.4M Cash - Seized: 01/15/2024 - Location: Vault B
echo  [EVIDENCE 003] Encrypted Phones (7) - Location: Tech Lab
timeout /t 0 /nobreak >nul
echo.
echo ════════════════════════════════════════════════════════════════════
echo  CASE #47294 - Terrorism Investigation
echo ════════════════════════════════════════════════════════════════════
echo  [EVIDENCE 001] Suspicious Documents - Location: Evidence Room 3
echo  [EVIDENCE 002] Computer Hard Drives (4) - Location: Cyber Lab
echo  [EVIDENCE 003] Weapons Cache - Location: Secure Vault C
timeout /t 0 /nobreak >nul
echo.
echo ════════════════════════════════════════════════════════════════════
echo  CASE #47296 - Securities Fraud
echo ════════════════════════════════════════════════════════════════════
echo  [EVIDENCE 001] Financial Records - Location: Document Archive
echo  [EVIDENCE 002] Server Backup (12TB) - Location: Digital Forensics
echo  [EVIDENCE 003] Email Communications - Location: Cloud Storage
timeout /t 0 /nobreak >nul
echo.
echo ════════════════════════════════════════════════════════════════════
echo  CASE #47300 - Bank Robbery
echo ════════════════════════════════════════════════════════════════════
echo  [EVIDENCE 001] Firearms (3) - Location: Ballistics Lab
echo  [EVIDENCE 002] Security Footage (HD) - Location: Media Room
echo  [EVIDENCE 003] DNA Samples - Location: Forensics Lab
timeout /t 0 /nobreak >nul
echo.
color 0c
call :type "[✓] 2,847 evidence items catalogued across 247 active cases"
color 0a
echo.
pause
goto fbi_menu

:delete_system32
cls
color 0c
title ⚠️ CRITICAL SYSTEM OPERATION ⚠️
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════╗
echo  ║                                                                            ║
echo  ║                    ⚠️  WARNING: CRITICAL OPERATION  ⚠️                      ║
echo  ║                                                                            ║
echo  ║         This will permanently delete Windows System32 directory            ║
echo  ║                      System will become UNBOOTABLE                         ║
echo  ║                                                                            ║
echo  ║                  Press any key to continue or CTRL+C to abort...           ║
echo  ║                                                                            ║
echo  ╚════════════════════════════════════════════════════════════════════════════╝
echo.
pause >nul

cls
color 0a
call :type "C:\Users\Admin> cd C:\Windows\System32"
call :type "C:\Windows\System32> takeown /f * /r /d y"
echo.
timeout /t 1 /nobreak >nul
echo [*] Taking ownership of protected system files...
timeout /t 1 /nobreak >nul
echo [✓] Ownership acquired - 4,287 files
echo.
call :type "C:\Windows\System32> icacls * /grant administrators:F /t"
echo [*] Granting full permissions...
timeout /t 1 /nobreak >nul
echo [✓] Permissions granted
echo.
echo.
color 0c
call :type "C:\Windows\System32> del /f /s /q *.*"
echo.
echo ════════════════════════════════════════════════════════════════════════════════
echo                          INITIATING DELETION SEQUENCE
echo ════════════════════════════════════════════════════════════════════════════════
echo.
timeout /t 1 /nobreak >nul

set "files=kernel32.dll ntoskrnl.exe hal.dll ntdll.dll user32.dll gdi32.dll advapi32.dll shell32.dll ole32.dll oleaut32.dll msvcrt.dll wininet.dll comctl32.dll comdlg32.dll winspool.drv ws2_32.dll rpcrt4.dll imm32.dll imagehlp.dll psapi.dll version.dll winmm.dll netapi32.dll setupapi.dll shlwapi.dll crypt32.dll secur32.dll wintrust.dll userenv.dll uxtheme.dll dwmapi.dll dbghelp.dll winload.exe winresume.exe ntfs.sys disk.sys acpi.sys"

for %%f in (%files%) do (
    echo [DELETING] C:\Windows\System32\%%f
    timeout /t 0 /nobreak >nul
)

echo.
echo [*] Wiping core OS components...
for /L %%i in (1,1,25) do (
    set /a "prog=%%i * 4"
    echo [████████████░░░░] !prog!%% - Removing protected objects...
    timeout /t 0 /nobreak >nul
)

cls
color 4f
echo.
echo.
echo     ███████╗ █████╗ ████████╗ █████╗ ██╗         ███████╗██████╗ ██████╗  ██████╗ ██████╗ 
echo     ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║         ██╔════╝██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
echo     █████╗  ███████║   ██║   ███████║██║         █████╗  ██████╔╝██████╔╝██║   ██║██████╔╝
echo     ██╔══╝  ██╔══██║   ██║   ██╔══██║██║         ██╔══╝  ██╔══██╗██╔══██╗██║   ██║██╔══██╗
echo     ██║     ██║  ██║   ██║   ██║  ██║███████╗    ███████╗██║  ██║██║  ██║╚██████╔╝██║  ██║
echo     ╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
echo.
echo.
timeout /t 2 /nobreak >nul
echo              ╔═══════════════════════════════════════════════════════╗
echo              ║                                                       ║
echo              ║       SYSTEM32 DELETION COMPLETE                      ║
echo              ║       STATUS: UNBOOTABLE                              ║
echo              ║       FILES REMOVED: 4,287                            ║
echo              ║                                                       ║
echo              ║       Windows will not boot on next restart           ║
echo              ║                                                       ║
echo              ╚═══════════════════════════════════════════════════════╝
echo.
echo.
timeout /t 3 /nobreak >nul
goto menu

:network_attack
cls
color 0a
call :type "[NETWORK] Scanning active connections..."
echo.
for /L %%i in (1,1,20) do (
    set /a "ip1=!random! %% 255"
    set /a "ip2=!random! %% 255"
    set /a "ip3=!random! %% 255"
    set /a "port=!random! %% 65535"
    echo [CONN] !ip1!.!ip2!.!ip3!.%%i:!port! ^| STATUS: ESTABLISHED ^| ENCRYPTION: AES-256
    timeout /t 0 /nobreak >nul
)
echo.
call :type "[EXPLOIT] Injecting payload..."
echo.
for /L %%i in (1,1,8) do (
    set /a "prog=%%i * 12"
    echo [████████░░░░░░░░] !prog!%% - Uploading shellcode...
    timeout /t 0 /nobreak >nul
)
echo.
color 0c
call :type "[✓] Network infiltration successful - 20 systems compromised"
color 0a
echo.
pause
goto menu

:crypto_mine
cls
color 0e
call :type "[CRYPTO] Initializing mining operation..."
echo.
call :type "[*] Connecting to mining pool: btc-pool-elite.onion"
call :type "[✓] Connected - Starting GPU threads"
echo.
for /L %%i in (1,1,20) do (
    set /a "hash=!random! * !random!"
    set /a "speed=!random! %% 500 + 100"
    echo [MINING] Block #%%i ^| Hash: 0x!hash! ^| Speed: !speed! MH/s
    timeout /t 0 /nobreak >nul
)
echo.
call :type "[✓] Mined 0.0047 BTC ($287.43)"
echo.
pause
goto menu

:password_crack
cls
color 0a
call :type "[PASSWORD CRACKER] Loading rainbow tables..."
timeout /t 1 /nobreak >nul
echo.
call :type "[*] Target: admin@corporate.com"
call :type "[*] Hash: 5f4dcc3b5aa765d61d8327deb882cf99"
echo.
call :type "[CRACKING] Attempting combinations..."
echo.
set "attempts=password123 admin123 letmein welcome1 qwerty123 Password1 Summer2024 Corporate123 Admin2024"
for %%p in (%attempts%) do (
    echo [TRYING] %%p...
    timeout /t 0 /nobreak >nul
)
echo.
color 0c
call :type "[✓] PASSWORD CRACKED: Admin2024"
color 0a
echo.
pause
goto menu

:: Function for typing effect
:type
set "text=%~1"
for /L %%i in (0,1,200) do (
    if not "!text:~%%i,1!"=="" (
        <nul set /p "=!text:~%%i,1!"
        timeout /t 0 /nobreak >nul
    )
)
echo.
goto :eof

:: Function for fake database output
:database
set /a "id=!random! %% 999999"
set /a "ssn=!random! %% 9 + 1"
for /L %%j in (1,1,8) do set /a "ssn=!ssn!!random! %% 10"
set "names=SMITH JOHNSON WILLIAMS BROWN JONES GARCIA MILLER DAVIS RODRIGUEZ MARTINEZ"
for /f "tokens=%random:~-1% delims= " %%a in ("!names!") do set "name=%%a"
echo [DB] Record #!id! ^| Name: !name! ^| SSN: !ssn:~0,3!-!ssn:~3,2!-!ssn:~5,4! ^| Status: EXTRACTED
goto :eof
