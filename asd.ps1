@echo off
setlocal EnableDelayedExpansion
title SYSTEM WATCHER
color 0a

:: --- CTRL+C IS THE ONLY EXIT ---
echo.
echo Press CTRL + C to terminate watcher.
echo Closing the window will NOT stop it.
echo.

:: --- WATCHER LOOP ---
:watch
start "" cmd /c "%~f0" run
ping localhost -n 2 >nul
goto watch

:: ===============================
:: ===== CHILD VISUAL MODE =======
:: ===============================
:run
chcp 65001 >nul
title █▓▒░ CRITICAL SYSTEM OPERATION ░▒▓█
color 0c
mode con cols=120 lines=40

:: ---- helpers ----
:delay
ping localhost -n %1 >nul
exit /b

:type
setlocal EnableDelayedExpansion
set "s=%~1"
for /L %%i in (0,1,500) do (
 set "c=!s:~%%i,1!"
 if "!c!"=="" goto end
 <nul set /p "=!c!"
 ping localhost -n 1 >nul
)
:end
echo.
endlocal
exit /b

:: ---- fake nuke ----
cls
call :type "CRITICAL ERROR: SYSTEM INTEGRITY FAILURE"
call :delay 2
call :type "FORCED REMEDIATION ENABLED"
call :delay 2

cls
echo TARGET:
echo C:\Windows\System32
echo.
call :type "Deleting protected system files..."
call :delay 2

for %%f in (
kernel32.dll
ntoskrnl.exe
winload.exe
hal.dll
drivers\disk.sys
drivers\acpi.sys
config\SAM
config\SYSTEM
) do (
 echo Deleting C:\Windows\System32\%%f
 ping localhost -n 1 >nul
)

cls
call :type "WIPING CORE OS COMPONENTS..."
for /L %%i in (1,1,30) do (
 echo [%%i/30] Removing critical object...
 ping localhost -n 1 >nul
)

cls
color 4f
call :type "SYSTEM FAILURE IMMINENT"
call :delay 2
call :type "OPERATING SYSTEM CORRUPTED"
call :delay 2

cls
color 0c
echo ███████████████████████████████████████
echo █   SYSTEM32 REMOVAL COMPLETE         █
echo █   STATUS: UNBOOTABLE                █
echo █   ACTION: RESTART REQUIRED          █
echo ███████████████████████████████████████
echo.

:: ---- wait forever until closed ----
pause >nul
exit
