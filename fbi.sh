#!/bin/bash

# FBI Hack Simulator - Linux/Arch Edition

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Set terminal
clear
echo -e "${GREEN}"

type_text() {
    text="$1"
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep 0.02
    done
    echo ""
}

show_menu() {
    clear
    echo -e "${RED}"
    echo "     ███████╗██████╗ ██╗    ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗     "
    echo "     ██╔════╝██╔══██╗██║    ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║     "
    echo "     █████╗  ██████╔╝██║       ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║     "
    echo "     ██╔══╝  ██╔══██╗██║       ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║     "
    echo "     ██║     ██████╔╝██║       ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗"
    echo "     ╚═╝     ╚═════╝ ╚═╝       ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝"
    echo ""
    echo -e "${GREEN}"
    echo "                          ╔═════════════════════════════════════════╗"
    echo "                          ║   CLASSIFIED ACCESS SYSTEM v4.7.2      ║"
    echo "                          ╚═════════════════════════════════════════╝"
    echo ""
    echo ""
    echo "                              ┌─────────────────────────────┐"
    echo "                              │    SELECT OPERATION:        │"
    echo "                              ├─────────────────────────────┤"
    echo "                              │                             │"
    echo "                              │  [1] FBI Database Hack      │"
    echo "                              │  [2] Delete System Files    │"
    echo "                              │  [3] Network Infiltration   │"
    echo "                              │  [4] Crypto Mining Attack   │"
    echo "                              │  [5] Password Cracker       │"
    echo "                              │  [6] Exit                   │"
    echo "                              │                             │"
    echo "                              └─────────────────────────────┘"
    echo ""
    echo -ne "                              ${GREEN}root@terminal:~# ${NC}"
}

fbi_hack_start() {
    clear
    echo -e "${GREEN}"
    echo "  ███████╗██████╗ ██╗    ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗"
    echo "  ██╔════╝██╔══██╗██║    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝"
    echo "  █████╗  ██████╔╝██║    ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗  "
    echo "  ██╔══╝  ██╔══██╗██║    ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝  "
    echo "  ██║     ██████╔╝██║    ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗"
    echo "  ╚═╝     ╚═════╝ ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝"
    echo ""
    echo -e "${YELLOW}                        [CLASSIFIED - TOP SECRET - EYES ONLY]${NC}"
    echo ""
    sleep 0.5
    
    # PHASE 1: Biometric
    type_text "[PHASE 1/6] Biometric Authentication Required"
    echo ""
    type_text "Place finger on scanner..."
    sleep 1
    echo ""
    echo "     ┌─────────────────────────┐"
    echo "     │   FINGERPRINT SCANNER   │"
    echo "     │                         │"
    echo "     │       ╔═══════╗         │"
    echo "     │      ║ ░░░░░░░║         │"
    echo "     │      ║░███░███░║         │"
    echo "     │      ║░░█████░░║         │"
    echo "     │      ║░██░█░██░║         │"
    echo "     │       ╚═══════╝         │"
    echo "     │                         │"
    echo "     │   SCANNING...           │"
    echo "     └─────────────────────────┘"
    sleep 2
    
    clear
    echo -e "${GREEN}"
    echo "  ███████╗██████╗ ██╗    ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗"
    echo "  ██╔════╝██╔══██╗██║    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝"
    echo "  █████╗  ██████╔╝██║    ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗  "
    echo "  ██╔══╝  ██╔══██╗██║    ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝  "
    echo "  ██║     ██████╔╝██║    ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗"
    echo "  ╚═╝     ╚═════╝ ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝"
    echo ""
    echo ""
    echo "     ┌─────────────────────────┐"
    echo "     │   RETINAL SCANNER       │"
    echo "     │                         │"
    echo "     │         ▓▓▓▓▓           │"
    echo "     │       ▓▓░░░░░▓▓         │"
    echo "     │      ▓░░░██░░░▓         │"
    echo "     │      ▓░░░██░░░▓         │"
    echo "     │       ▓▓░░░░░▓▓         │"
    echo "     │         ▓▓▓▓▓           │"
    echo "     │                         │"
    echo "     │   SCANNING RETINA...    │"
    echo "     └─────────────────────────┘"
    sleep 2
    echo ""
    echo -e "${RED}[✓] BIOMETRIC MATCH - Director Level Clearance${NC}"
    echo ""
    sleep 1
    
    # PHASE 2-6
    clear
    type_text "[PHASE 2/6] Initiating secure connection to FBI mainframe..."
    echo ""
    type_text "Connecting to: fbi-sentinel.gov (192.168.254.100:8443)"
    sleep 1
    echo "[*] Establishing encrypted tunnel..."
    sleep 1
    echo "[*] SSL/TLS Handshake... OK"
    echo "[*] Certificate validation... OK"
    sleep 1
    echo -e "${RED}[✓] SECURE CONNECTION ESTABLISHED${NC}"
    echo ""
    sleep 1
    
    type_text "[PHASE 3/6] Bypassing multi-factor authentication..."
    echo ""
    echo "[*] Intercepting 2FA token..."
    sleep 1
    echo "[*] Token captured: 847291"
    echo "[*] Replaying authentication sequence..."
    sleep 1
    echo -e "${RED}[✓] 2FA BYPASSED${NC}"
    echo ""
    sleep 1
    
    type_text "[PHASE 4/6] Disabling security systems..."
    echo ""
    echo "[*] Killing firewall processes... DONE"
    echo "[*] Disabling IDS/IPS monitoring... DONE"
    echo "[*] Stopping antivirus services... DONE"
    echo "[*] Erasing access logs... DONE"
    sleep 1
    echo -e "${RED}[✓] ALL SECURITY SYSTEMS DISABLED${NC}"
    echo ""
    sleep 1
    
    type_text "[PHASE 5/6] Installing persistent backdoor..."
    echo ""
    echo "[*] Uploading payload... ████████████████ 100%"
    sleep 1
    echo "[*] Configuring autostart... DONE"
    echo "[*] Hiding process from task manager... DONE"
    sleep 1
    echo -e "${RED}[✓] BACKDOOR INSTALLED - PERSISTENT ACCESS GRANTED${NC}"
    echo ""
    sleep 1
    
    type_text "[PHASE 6/6] Accessing SENTINEL database..."
    echo ""
    sleep 2
    echo -e "${RED}[✓✓✓] FULL SYSTEM ACCESS GRANTED [✓✓✓]${NC}"
    echo ""
    sleep 1
    read -p "Press Enter to continue..."
    
    fbi_menu
}

fbi_menu() {
    while true; do
        clear
        echo -e "${GREEN}"
        echo "  ███████╗███████╗███╗   ██╗████████╗██╗███╗   ██╗███████╗██╗         "
        echo "  ██╔════╝██╔════╝████╗  ██║╚══██╔══╝██║████╗  ██║██╔════╝██║         "
        echo "  ███████╗█████╗  ██╔██╗ ██║   ██║   ██║██╔██╗ ██║█████╗  ██║         "
        echo "  ╚════██║██╔══╝  ██║╚██╗██║   ██║   ██║██║╚██╗██║██╔══╝  ██║         "
        echo "  ███████║███████╗██║ ╚████║   ██║   ██║██║ ╚████║███████╗███████╗    "
        echo "  ╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝    "
        echo ""
        echo -e "${YELLOW}                        FBI DATABASE ACCESS SYSTEM${NC}"
        echo -e "${GREEN}════════════════════════════════════════════════════════════════════════${NC}"
        echo ""
        echo "     [1] Track Suspects (GPS)          [7] Agent Profiles"
        echo "     [2] Criminal Records               [8] Satellite Uplink"
        echo "     [3] Active Investigations          [9] Webcam Access"
        echo "     [4] Classified Documents          [10] Download Files"
        echo "     [5] Surveillance Footage          [11] Evidence Locker"
        echo "     [6] Witness Protection            [12] Back to Main Menu"
        echo ""
        echo -e "${GREEN}════════════════════════════════════════════════════════════════════════${NC}"
        echo -ne "${GREEN}SELECT DATABASE: ${NC}"
        read choice
        
        case $choice in
            1) track_suspects ;;
            2) criminal_records ;;
            3) active_investigations ;;
            4) classified_documents ;;
            5) surveillance_footage ;;
            6) witness_protection ;;
            7) agent_profiles ;;
            8) satellite_uplink ;;
            9) webcam_access ;;
            10) download_files ;;
            11) evidence_locker ;;
            12) return ;;
            *) ;;
        esac
    done
}

track_suspects() {
    clear
    type_text "[GPS TRACKING] Accessing real-time suspect locations..."
    echo ""
    sleep 1
    echo "┌────────────────────────────────────────────────────────────────────┐"
    echo "│                    ACTIVE SUSPECT TRACKING                         │"
    echo "├────────────────────────────────────────────────────────────────────┤"
    echo "│                                                                    │"
    
    lat1=$((40 + RANDOM % 10))
    lon1=$((-74 - RANDOM % 10))
    echo "│  [SUSPECT #1847] John Martinez                                     │"
    echo "│  Status: ARMED AND DANGEROUS                                       │"
    echo "│  Location: ${lat1}.$((RANDOM % 9999))°N, ${lon1}.$((RANDOM % 9999))°W                                  │"
    echo "│  Address: 742 Broadway St, New York, NY                            │"
    echo "│  Speed: 45 MPH - Moving North                                      │"
    echo "│  Last Update: 3 seconds ago                                        │"
    echo "│                                                                    │"
    sleep 1
    
    lat2=$((34 + RANDOM % 10))
    lon2=$((-118 - RANDOM % 10))
    echo "│  [SUSPECT #2891] Sarah Chen                                        │"
    echo "│  Status: WANTED - CYBER CRIMES                                     │"
    echo "│  Location: ${lat2}.$((RANDOM % 9999))°N, ${lon2}.$((RANDOM % 9999))°W                                 │"
    echo "│  Address: 1523 Sunset Blvd, Los Angeles, CA                        │"
    echo "│  Speed: STATIONARY                                                 │"
    echo "│  Last Update: 1 second ago                                         │"
    echo "│                                                                    │"
    sleep 1
    
    lat3=$((41 + RANDOM % 10))
    lon3=$((-87 - RANDOM % 10))
    echo "│  [SUSPECT #3247] Michael Torres                                    │"
    echo "│  Status: FUGITIVE - DO NOT APPROACH                                │"
    echo "│  Location: ${lat3}.$((RANDOM % 9999))°N, ${lon3}.$((RANDOM % 9999))°W                                 │"
    echo "│  Address: 891 Michigan Ave, Chicago, IL                            │"
    echo "│  Speed: 67 MPH - Moving East                                       │"
    echo "│  Last Update: 5 seconds ago                                        │"
    echo "│                                                                    │"
    echo "└────────────────────────────────────────────────────────────────────┘"
    echo ""
    echo -e "${RED}[✓] 47 suspects being tracked in real-time${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

criminal_records() {
    clear
    type_text "[DATABASE] Accessing criminal records..."
    echo ""
    
    names=("SMITH" "JOHNSON" "WILLIAMS" "BROWN" "JONES" "GARCIA" "MILLER" "DAVIS" "RODRIGUEZ" "MARTINEZ")
    
    for i in {1..15}; do
        id=$((RANDOM % 999999))
        ssn=""
        for j in {1..9}; do
            ssn="${ssn}$((RANDOM % 10))"
        done
        name=${names[$RANDOM % ${#names[@]}]}
        formatted_ssn="${ssn:0:3}-${ssn:3:2}-${ssn:5:4}"
        echo "[DB] Record #${id} | Name: ${name} | SSN: ${formatted_ssn} | Status: EXTRACTED"
    done
    
    echo ""
    echo -e "${RED}[✓] Downloaded 15,847 criminal records${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

active_investigations() {
    clear
    type_text "[DATABASE] Retrieving active investigations..."
    echo ""
    echo "[CASE #47291] Operation Dark Web - Drug Trafficking - Status: ACTIVE"
    echo "[CASE #47292] Cyber Espionage - Foreign Interference - Status: CLASSIFIED"
    echo "[CASE #47293] Money Laundering - Organized Crime - Status: ACTIVE"
    echo "[CASE #47294] Terrorism Investigation - Threat Level: HIGH"
    echo "[CASE #47295] Kidnapping - Amber Alert - Status: URGENT"
    echo "[CASE #47296] White Collar Crime - Securities Fraud - Status: ACTIVE"
    echo "[CASE #47297] Human Trafficking - Multi-State - Status: CLASSIFIED"
    echo "[CASE #47298] Arson Investigation - Federal Property - Status: ACTIVE"
    echo "[CASE #47299] Political Corruption - Congress Member - Status: TOP SECRET"
    echo "[CASE #47300] Bank Robbery - Armed Suspects - Status: MANHUNT"
    echo ""
    echo -e "${RED}[✓] 247 active investigations retrieved${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

classified_documents() {
    clear
    type_text "[DATABASE] Downloading classified documents..."
    echo ""
    echo "[DOWNLOADING] PROJECT_SENTINEL.pdf (127 MB) ████████████████ 100%"
    echo "[DOWNLOADING] OPERATION_BLACKOUT.docx (43 MB) ████████████████ 100%"
    echo "[DOWNLOADING] WITNESS_LIST_2024.xlsx (89 MB) ████████████████ 100%"
    echo "[DOWNLOADING] SURVEILLANCE_PROTOCOLS.pdf (156 MB) ████████████████ 100%"
    echo "[DOWNLOADING] ASSET_SEIZURE_RECORDS.pdf (201 MB) ████████████████ 100%"
    echo "[DOWNLOADING] UNDERCOVER_AGENTS.xlsx (73 MB) ████████████████ 100%"
    echo "[DOWNLOADING] INFORMANT_DATABASE.db (341 MB) ████████████████ 100%"
    echo ""
    echo -e "${RED}[✓] 7 TOP SECRET documents downloaded (1.03 GB total)${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

surveillance_footage() {
    clear
    type_text "[SURVEILLANCE] Accessing security camera feeds..."
    echo ""
    echo "[CAMERA 001] NYC - Times Square - ACTIVE - Recording"
    echo "[CAMERA 002] LA - Federal Building - ACTIVE - Recording"
    echo "[CAMERA 003] Chicago - O'Hare Airport - ACTIVE - Recording"
    echo "[CAMERA 004] Miami - Port Authority - ACTIVE - Recording"
    echo "[CAMERA 005] DC - Capitol Building - ACTIVE - Recording"
    echo "[CAMERA 006] Houston - FBI Field Office - ACTIVE - Recording"
    echo "[CAMERA 007] Phoenix - Border Checkpoint - ACTIVE - Recording"
    echo ""
    type_text "[AUDIO] Accessing wiretap recordings..."
    echo ""
    echo "[WIRETAP 891] Target: John Martinez - Duration: 47:23 - DOWNLOADING..."
    sleep 1
    echo "[WIRETAP 892] Target: Sarah Chen - Duration: 31:56 - DOWNLOADING..."
    sleep 1
    echo "[WIRETAP 893] Target: Unknown - Duration: 1:14:09 - DOWNLOADING..."
    sleep 1
    echo ""
    echo -e "${RED}[✓] 127 surveillance feeds accessed | 45 wiretaps downloaded${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

witness_protection() {
    clear
    type_text "[DATABASE] Accessing Witness Protection Program..."
    echo ""
    echo -e "${RED}[⚠️  WARNING] This database contains HIGHLY SENSITIVE information${NC}"
    sleep 1
    echo ""
    echo "[WITNESS ID: WP-2891] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED"
    echo "[WITNESS ID: WP-2892] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED"
    echo "[WITNESS ID: WP-2893] Name: [REDACTED] - Location: [REDACTED] - Status: RELOCATED"
    echo "[WITNESS ID: WP-2894] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED"
    echo "[WITNESS ID: WP-2895] Name: [REDACTED] - Location: [REDACTED] - Status: COMPROMISED"
    echo "[WITNESS ID: WP-2896] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED"
    echo "[WITNESS ID: WP-2897] Name: [REDACTED] - Location: [REDACTED] - Status: PROTECTED"
    echo ""
    echo -e "${RED}[✓] 1,247 witness records accessed${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

agent_profiles() {
    clear
    type_text "[DATABASE] Accessing FBI Agent Profiles..."
    echo ""
    sleep 1
    echo "════════════════════════════════════════════════════════════════════"
    echo -e "${YELLOW}  AGENT PROFILE #001${NC}"
    echo "════════════════════════════════════════════════════════════════════"
    echo "  Name: Special Agent James Rodriguez"
    echo "  Badge: SA-47291"
    echo "  Division: Cyber Crimes"
    echo "  Clearance: Level 5 - Top Secret"
    echo "  Location: Washington D.C. Field Office"
    echo "  Status: ACTIVE - Currently on assignment"
    echo "  Cases: 47 closed | 12 active"
    echo "════════════════════════════════════════════════════════════════════"
    sleep 1
    echo ""
    echo "════════════════════════════════════════════════════════════════════"
    echo -e "${YELLOW}  AGENT PROFILE #002${NC}"
    echo "════════════════════════════════════════════════════════════════════"
    echo "  Name: Special Agent Emily Carter"
    echo "  Badge: SA-39182"
    echo "  Division: Counter-Terrorism"
    echo "  Clearance: Level 6 - Classified"
    echo "  Location: New York Field Office"
    echo "  Status: ACTIVE - Undercover operation"
    echo "  Cases: 89 closed | 8 active"
    echo "════════════════════════════════════════════════════════════════════"
    sleep 1
    echo ""
    echo "════════════════════════════════════════════════════════════════════"
    echo -e "${YELLOW}  AGENT PROFILE #003${NC}"
    echo "════════════════════════════════════════════════════════════════════"
    echo "  Name: Special Agent Michael Chen"
    echo "  Badge: SA-51847"
    echo "  Division: Organized Crime"
    echo "  Clearance: Level 5 - Top Secret"
    echo "  Location: Los Angeles Field Office"
    echo "  Status: ACTIVE - Field assignment"
    echo "  Cases: 62 closed | 15 active"
    echo "════════════════════════════════════════════════════════════════════"
    echo ""
    echo -e "${RED}[✓] 3,847 agent profiles accessed${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

satellite_uplink() {
    clear
    type_text "[SATELLITE] Establishing connection to surveillance satellites..."
    echo ""
    sleep 1
    echo "[*] Connecting to KEYHOLE-12 satellite network..."
    sleep 1
    echo "[*] Authentication: ACCEPTED"
    echo "[*] Uplink established"
    sleep 1
    echo -e "${RED}[✓] SATELLITE CONNECTION ACTIVE${NC}"
    echo ""
    sleep 1
    echo "┌────────────────────────────────────────────────────────────────┐"
    echo "│                  ACTIVE SATELLITES                             │"
    echo "├────────────────────────────────────────────────────────────────┤"
    echo "│                                                                │"
    echo "│  [SAT-01] KEYHOLE-12A   - Orbit: 380km - Status: OPERATIONAL   │"
    echo "│  [SAT-02] KEYHOLE-12B   - Orbit: 385km - Status: OPERATIONAL   │"
    echo "│  [SAT-03] LACROSSE-5    - Orbit: 680km - Status: OPERATIONAL   │"
    echo "│  [SAT-04] MERCURY-7     - Orbit: 420km - Status: OPERATIONAL   │"
    echo "│                                                                │"
    echo "└────────────────────────────────────────────────────────────────┘"
    echo ""
    type_text "[SATELLITE] Accessing real-time imaging..."
    echo ""
    echo "[IMAGE 001] Target: 40.7128°N, 74.0060°W (NYC) - Resolution: 0.3m"
    echo "[IMAGE 002] Target: 34.0522°N, 118.2437°W (LA) - Resolution: 0.3m"
    echo "[IMAGE 003] Target: 41.8781°N, 87.6298°W (Chicago) - Resolution: 0.3m"
    echo ""
    type_text "[SATELLITE] Tracking mobile targets..."
    echo ""
    echo "[TRACKING] Vehicle plate: ABC-1234 - Last seen: 5 minutes ago"
    echo "[TRACKING] Suspect: John Martinez - Current location acquired"
    echo ""
    echo -e "${RED}[✓] 4 satellites online | Real-time tracking active${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

webcam_access() {
    clear
    type_text "[WEBCAM] Accessing remote webcam feeds..."
    echo ""
    sleep 1
    echo -e "${RED}[⚠️  WARNING] Unauthorized access to private devices${NC}"
    sleep 1
    echo ""
    echo "[WEBCAM 001] IP: 192.168.1.47 - Location: New York, NY - ACTIVE"
    echo "[WEBCAM 002] IP: 10.0.0.158 - Location: Los Angeles, CA - ACTIVE"
    echo "[WEBCAM 003] IP: 172.16.0.92 - Location: Chicago, IL - ACTIVE"
    echo "[WEBCAM 004] IP: 192.168.0.201 - Location: Houston, TX - ACTIVE"
    echo "[WEBCAM 005] IP: 10.1.1.88 - Location: Phoenix, AZ - ACTIVE"
    echo "[WEBCAM 006] IP: 172.20.0.156 - Location: Miami, FL - ACTIVE"
    echo ""
    type_text "[RECORDING] Starting video capture..."
    echo ""
    
    for i in {1..10}; do
        prog=$((i * 10))
        echo "[████████░░░░░░░░] ${prog}% - Recording footage..."
        sleep 0.2
    done
    
    echo ""
    type_text "[AUDIO] Accessing microphone feeds..."
    echo ""
    echo "[MIC 001] Device detected - Recording audio... ACTIVE"
    echo "[MIC 002] Device detected - Recording audio... ACTIVE"
    echo "[MIC 003] Device detected - Recording audio... ACTIVE"
    echo ""
    echo -e "${RED}[✓] 47 webcams accessed | 32 audio feeds active${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

download_files() {
    clear
    type_text "[FILE TRANSFER] Downloading classified files to local system..."
    echo ""
    sleep 1
    
    downloadPath="$HOME/Downloads/FBI_CLASSIFIED_DATA.txt"
    mkdir -p "$HOME/Downloads"
    
    cat > "$downloadPath" << EOF
════════════════════════════════════════════════════════════
 FBI CLASSIFIED DATABASE EXTRACT
 ACCESS LEVEL: TOP SECRET
 EXTRACTED: $(date)
════════════════════════════════════════════════════════════

 Ha! You thought you actually hacked the FBI, didn't you?

 This is just a harmless bash script for fun.
 No real data was accessed or downloaded.
 No systems were harmed.

 Hope you enjoyed the show! ;)

════════════════════════════════════════════════════════════
EOF
    
    echo "[DOWNLOADING] FBI_CLASSIFIED_DATA.txt"
    echo ""
    
    for i in {1..20}; do
        prog=$((i * 5))
        echo "[████████████████░░░░] ${prog}% - Transferring encrypted data..."
        sleep 0.1
    done
    
    echo ""
    echo -e "${RED}[✓] File downloaded to: $downloadPath${NC}"
    echo ""
    echo "Opening file..."
    sleep 2
    
    if command -v xdg-open &> /dev/null; then
        xdg-open "$downloadPath" 2>/dev/null
    elif command -v nano &> /dev/null; then
        nano "$downloadPath"
    elif command -v vim &> /dev/null; then
        vim "$downloadPath"
    else
        cat "$downloadPath"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
}

evidence_locker() {
    clear
    type_text "[EVIDENCE] Accessing FBI Evidence Locker Database..."
    echo ""
    sleep 1
    echo -e "${RED}[⚠️  RESTRICTED] Chain of Custody Required${NC}"
    sleep 1
    echo ""
    echo "════════════════════════════════════════════════════════════════════"
    echo -e "${YELLOW}  CASE #47291 - Drug Trafficking Operation${NC}"
    echo "════════════════════════════════════════════════════════════════════"
    echo "  [EVIDENCE 001] 25kg Cocaine - Seized: 01/15/2024 - Location: Vault A"
    echo "  [EVIDENCE 002] \$2.4M Cash - Seized: 01/15/2024 - Location: Vault B"
    echo "  [EVIDENCE 003] Encrypted Phones (7) - Location: Tech Lab"
    echo ""
    echo "════════════════════════════════════════════════════════════════════"
    echo -e "${YELLOW}  CASE #47294 - Terrorism Investigation${NC}"
    echo "════════════════════════════════════════════════════════════════════"
    echo "  [EVIDENCE 001] Suspicious Documents - Location: Evidence Room 3"
    echo "  [EVIDENCE 002] Computer Hard Drives (4) - Location: Cyber Lab"
    echo "  [EVIDENCE 003] Weapons Cache - Location: Secure Vault C"
    echo ""
    echo "════════════════════════════════════════════════════════════════════"
    echo -e "${YELLOW}  CASE #47296 - Securities Fraud${NC}"
    echo "════════════════════════════════════════════════════════════════════"
    echo "  [EVIDENCE 001] Financial Records - Location: Document Archive"
    echo "  [EVIDENCE 002] Server Backup (12TB) - Location: Digital Forensics"
    echo "  [EVIDENCE 003] Email Communications - Location: Cloud Storage"
    echo ""
    echo "════════════════════════════════════════════════════════════════════"
    echo -e "${YELLOW}  CASE #47300 - Bank Robbery${NC}"
    echo "════════════════════════════════════════════════════════════════════"
    echo "  [EVIDENCE 001] Firearms (3) - Location: Ballistics Lab"
    echo "  [EVIDENCE 002] Security Footage (HD) - Location: Media Room"
    echo "  [EVIDENCE 003] DNA Samples - Location: Forensics Lab"
    echo ""
    echo -e "${RED}[✓] 2,847 evidence items catalogued across 247 active cases${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

delete_system() {
    clear
    echo -e "${RED}"
    echo ""
    echo "  ╔════════════════════════════════════════════════════════════════════════════╗"
    echo "  ║                                                                            ║"
    echo "  ║                    ⚠️  WARNING: CRITICAL OPERATION  ⚠️                      ║"
    echo "  ║                                                                            ║"
    echo "  ║         This will permanently delete critical system files                ║"
    echo "  ║                      System will become UNBOOTABLE                         ║"
    echo "  ║                                                                            ║"
    echo "  ║                  Press Enter to continue or CTRL+C to abort...             ║"
    echo "  ║                                                                            ║"
    echo "  ╚════════════════════════════════════════════════════════════════════════════╝"
    echo ""
    read -p ""
    
    clear
    echo -e "${GREEN}"
    type_text "root@arch:~# cd /usr/lib"
    type_text "root@arch:/usr/lib# rm -rf *"
    echo ""
    sleep 1
    echo "[*] Removing critical system libraries..."
    sleep 1
    echo "[✓] Permissions acquired - 8,472 files"
    echo ""
    type_text "root@arch:/usr/lib# cd /boot"
    type_text "root@arch:/boot# rm -rf *"
    echo "[*] Removing boot files..."
    sleep 1
    echo "[✓] Boot files removed"
    echo ""
    echo ""
    echo -e "${RED}"
    type_text "root@arch:~# rm -rf --no-preserve-root /"
    echo ""
    echo "════════════════════════════════════════════════════════════════════════════════"
    echo "                          INITIATING DELETION SEQUENCE"
    echo "════════════════════════════════════════════════════════════════════════════════"
    echo ""
    sleep 1
    
    files=("libc.so.6" "ld-linux.so.2" "libpthread.so.0" "libm.so.6" "libdl.so.2" "librt.so.1" "systemd" "init" "bash" "kernel" "modules" "grub.cfg" "vmlinuz" "initramfs")
    
    for file in "${files[@]}"; do
        echo "[DELETING] /usr/lib/$file"
        sleep 0.05
    done
    
    echo ""
    echo "[*] Wiping core system components..."
    
    for i in {1..25}; do
        prog=$((i * 4))
        echo "[████████████░░░░] ${prog}% - Removing protected objects..."
        sleep 0.1
    done
    
    # Red background effect
    tput setab 1
    tput setaf 7
    clear
    echo ""
    echo ""
    echo "     ███████╗ █████╗ ████████╗ █████╗ ██╗         ███████╗██████╗ ██████╗  ██████╗ ██████╗ "
    echo "     ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██║         ██╔════╝██╔══██╗██╔══██╗██╔═══██╗██╔══██╗"
    echo "     █████╗  ███████║   ██║   ███████║██║         █████╗  ██████╔╝██████╔╝██║   ██║██████╔╝"
    echo "     ██╔══╝  ██╔══██║   ██║   ██╔══██║██║         ██╔══╝  ██╔══██╗██╔══██╗██║   ██║██╔══██╗"
    echo "     ██║     ██║  ██║   ██║   ██║  ██║███████╗    ███████╗██║  ██║██║  ██║╚██████╔╝██║  ██║"
    echo "     ╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝"
    echo ""
    echo ""
    sleep 2
    echo "              ╔═══════════════════════════════════════════════════════╗"
    echo "              ║                                                       ║"
    echo "              ║       SYSTEM DELETION COMPLETE                        ║"
    echo "              ║       STATUS: UNBOOTABLE                              ║"
    echo "              ║       FILES REMOVED: 8,472                            ║"
    echo "              ║                                                       ║"
    echo "              ║       System will not boot on next restart            ║"
    echo "              ║                                                       ║"
    echo "              ╚═══════════════════════════════════════════════════════╝"
    echo ""
    echo ""
    sleep 3
    
    # Reset colors
    tput sgr0
    clear
}

network_attack() {
    clear
    type_text "[NETWORK] Scanning active connections..."
    echo ""
    
    for i in {1..20}; do
        ip1=$((RANDOM % 255))
        ip2=$((RANDOM % 255))
        ip3=$((RANDOM % 255))
        port=$((RANDOM % 65535))
        echo "[CONN] ${ip1}.${ip2}.${ip3}.${i}:${port} | STATUS: ESTABLISHED | ENCRYPTION: AES-256"
        sleep 0.05
    done
    
    echo ""
    type_text "[EXPLOIT] Injecting payload..."
    echo ""
    
    for i in {1..8}; do
        prog=$((i * 12))
        echo "[████████░░░░░░░░] ${prog}% - Uploading shellcode..."
        sleep 0.2
    done
    
    echo ""
    echo -e "${RED}[✓] Network infiltration successful - 20 systems compromised${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

crypto_mine() {
    clear
    echo -e "${YELLOW}"
    type_text "[CRYPTO] Initializing mining operation..."
    echo ""
    type_text "[*] Connecting to mining pool: btc-pool-elite.onion"
    type_text "[✓] Connected - Starting GPU threads"
    echo ""
    
    for i in {1..20}; do
        hash=$((RANDOM % 999999999))
        speed=$((RANDOM % 500 + 100))
        echo "[MINING] Block #${i} | Hash: 0x${hash} | Speed: ${speed} MH/s"
        sleep 0.1
    done
    
    echo ""
    type_text "[✓] Mined 0.0047 BTC (\$287.43)"
    echo ""
    echo -e "${GREEN}"
    read -p "Press Enter to continue..."
}

password_crack() {
    clear
    type_text "[PASSWORD CRACKER] Loading rainbow tables..."
    sleep 1
    echo ""
    type_text "[*] Target: admin@corporate.com"
    type_text "[*] Hash: 5f4dcc3b5aa765d61d8327deb882cf99"
    echo ""
    type_text "[CRACKING] Attempting combinations..."
    echo ""
    
    attempts=("password123" "admin123" "letmein" "welcome1" "qwerty123" "Password1" "Summer2024" "Corporate123" "Admin2024")
    
    for attempt in "${attempts[@]}"; do
        echo "[TRYING] $attempt..."
        sleep 0.2
    done
    
    echo ""
    echo -e "${RED}[✓] PASSWORD CRACKED: Admin2024${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

# Main loop
while true; do
    show_menu
    read choice
    
    case $choice in
        1) fbi_hack_start ;;
        2) delete_system ;;
        3) network_attack ;;
        4) crypto_mine ;;
        5) password_crack ;;
        6) exit 0 ;;
        *) ;;
    esac
done
