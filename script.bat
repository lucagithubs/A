@echo off
:: --- Resize CMD text ---
mode con: cols=120 lines=40

:: --- Fetch ASCII animation via curl ---
:: Make sure curl is installed or included in Windows 10+
curl ascii.live/rick

:: --- Keep CMD open after animation ---
pause
