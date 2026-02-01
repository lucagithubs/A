@echo off
chcp 65001 >nul
title █▓▒░ CRITICAL SYSTEM OPERATION ░▒▓█
color 0c
mode con cols=120 lines=40

cls
echo ======================================================
echo  CRITICAL SYSTEM PROCESS ACTIVE
echo  DO NOT CLOSE THIS WINDOW
echo.
echo  Press CTRL + C to abort operation
echo ======================================================
ping localhost -n 3 >nul

cls
echo TARGET DIRECTORY:
echo C:\Windows\System32
echo.
echo Initializing deletion sequence...
ping localhost -n 2 >nul

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
echo WIPING CORE OS COMPONENTS...
for /L %%i in (1,1,30) do (
    echo [%%i/30] Removing protected object...
    ping localhost -n 1 >nul
)

cls
color 4f
echo SYSTEM FAILURE IMMINENT
ping localhost -n 2 >nul
echo OPERATING SYSTEM CORRUPTED
ping localhost -n 2 >nul

cls
color 0c
echo ███████████████████████████████████████
echo █   SYSTEM32 REMOVAL COMPLETE         █
echo █   STATUS: UNBOOTABLE                █
echo █                                    █
echo █   PRESS CTRL + C TO TERMINATE       █
echo ███████████████████████████████████████
echo.

:: keep running forever unless CTRL+C
:hold
ping localhost -n 10 >nul
goto hold
