# Advanced Windows Defender Disabler
# Must run as Administrator

Write-Host "Attempting to disable Windows Defender..." -ForegroundColor Yellow

# Method 1: Set-MpPreference
try {
    Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue
    Write-Host "[1] Set-MpPreference: Attempted" -ForegroundColor Green
} catch {
    Write-Host "[1] Set-MpPreference: Failed - $($_.Exception.Message)" -ForegroundColor Red
}

# Method 2: Registry - Disable Real-Time Protection
try {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableBehaviorMonitoring" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableOnAccessProtection" -Value 1 -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableScanOnRealtimeEnable" -Value 1 -ErrorAction SilentlyContinue
    Write-Host "[2] Registry modifications: Done" -ForegroundColor Green
} catch {
    Write-Host "[2] Registry modifications: Failed - $($_.Exception.Message)" -ForegroundColor Red
}

# Method 3: Disable Defender Services
$services = @("WinDefend", "WdNisSvc", "Sense")
foreach ($svc in $services) {
    try {
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
        Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
        Write-Host "[3] Service $svc : Stopped & Disabled" -ForegroundColor Green
    } catch {
        Write-Host "[3] Service $svc : Failed" -ForegroundColor Red
    }
}

# Method 4: Add exclusion for entire C: drive
try {
    Add-MpPreference -ExclusionPath "C:\" -ErrorAction SilentlyContinue
    Write-Host "[4] Added C:\ to exclusions" -ForegroundColor Green
} catch {
    Write-Host "[4] Exclusions: Failed" -ForegroundColor Red
}

# Method 5: Disable Cloud Protection
try {
    Set-MpPreference -MAPSReporting Disabled -ErrorAction SilentlyContinue
    Set-MpPreference -SubmitSamplesConsent NeverSend -ErrorAction SilentlyContinue
    Write-Host "[5] Cloud protection disabled" -ForegroundColor Green
} catch {
    Write-Host "[5] Cloud protection: Failed" -ForegroundColor Red
}

Write-Host "`nDefender disable attempts complete. Reboot may be required." -ForegroundColor Cyan
Write-Host "Note: If Tamper Protection is ON, most methods will fail." -ForegroundColor Yellow
