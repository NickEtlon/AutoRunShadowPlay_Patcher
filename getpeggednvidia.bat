@echo off
setlocal
color a
title ShadowPlay Patcher Automator

echo [1/4] Locating ShadowPlay_Patcher.exe...
timeout /t 2 >nul

:: Check if the executable exists in the current directory
if not exist "ShadowPlay_Patcher.exe" (
    echo [ERROR] ShadowPlay_Patcher.exe not found in this folder!
    echo Please place this script in the same folder as the patcher.
    pause
    exit /b
)

echo [2/4] Setting up paths...
timeout /t 1 >nul

:: Define paths
set "programsPath=%appdata%\Microsoft\Windows\Start Menu\Programs"
set "startupPath=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
set "destExe=%programsPath%\ShadowPlay_Patcher.exe"
set "batchFile=%startupPath%\Run_ShadowPlay_Patcher.bat"

echo [3/4] Copying executable to Programs folder...
:: Copy the executable to the Programs directory
xcopy /Y "ShadowPlay_Patcher.exe" "%programsPath%\" >nul
if errorlevel 1 (
    echo [ERROR] Failed to copy the executable.
    pause
    exit /b
)
echo [+] Patcher successfully linked to Programs folder.

echo [4/4] Creating Startup batch file...
:: Create a batch file in Startup to run the executable with no-wait argument
(
    echo @echo off
    echo start "" "%destExe%" --no-wait-for-keypress
) > "%batchFile%"
if errorlevel 1 (
    echo [ERROR] Failed to create the startup batch file.
    pause
    exit /b
)
echo [+] Startup batch file created successfully.

echo [+] Opening ShadowPlay_Patcher.exe now...
start "" "%destExe%" --no-wait-for-keypress

echo.
echo This window will close in 3 seconds...
timeout /t 3
exit