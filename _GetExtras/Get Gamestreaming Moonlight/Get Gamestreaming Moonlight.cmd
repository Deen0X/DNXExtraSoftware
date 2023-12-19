@echo off
cd /d "%~dp0"
pushd "%~dp0"
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion

:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=C:\Program Files\Moonlight Game Streaming\Moonlight.exe"
::#################################################################################################
set xDESCEXTRA=Moonlight PC is an open source PC client for NVIDIA GameStream and Sunshine. You can stream games from your gaming PC to your portable device and/or other PCs.
::#################################################################################################
set xSOURCE=https://github.com/moonlight-stream/moonlight-qt
::#################################################################################################
set xDownload=https://github.com/moonlight-stream/moonlight-qt/releases/download/v5.0.1/MoonlightSetup-5.0.1.exe
::#################################################################################################

if "_%1"=="_/GETEXTRA" goto getExtra
goto addEntry


:addEntry
::================================================================================================= Check if EXTRA exist
echo "%checkEXTRA%"
if exist "%checkEXTRA%" goto removeEntry
::------------------------------------------------------------------------------------------------- Add Entry if not exist
echo --- addEntry
set myP=%~dp0
set myP=%myP:~0,-1%
set "myICO=C:\DNXSoftware\Extras\_GetExtras\DNXEXTRAS.ico"
if exist "%~dpn0.ico" set "myICO=%~dpn0.ico"
call "C:\DNXSoftware\Extras\_GetExtras\createlnk.cmd" "%~dpnx0" "%myP%" "%mySN%" "/GETEXTRA" "%myICO%"
cd %myP%
if not exist "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_Extra Software\" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_Extra Software\"
move /Y "%~dpn0.lnk" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_Extra Software\" >nul
goto endScript

::------------------------------------------------------------------------------------------------- Remove Entry if exist
:removeEntry
echo --- removeEntry
if exist "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_Extra Software\%mySN%.lnk" del "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_Extra Software\%mySN%.lnk" >nul
goto endScript

::================================================================================================= Start Main Script for Get EXTRA
:getExtra
echo --- getExtra

::================================================================================================= Check for permissions
:getAdminPriv
::>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
::REM --> If error flag set, we do not have admin.
::if '%errorlevel%' NEQ '0' (
::    echo Requesting administrative privileges...
::    goto UACPrompt
::) else ( goto gotAdmin )
::
:::UACPrompt
::    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\\getadmin.vbs"
::    set params = %*:"="
::    ::echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
::    echo UAC.ShellExecute "cmd.exe", "/c  %~s0 %1 %2 %3", "", "runas", 1 >> "%temp%\\getadmin.vbs"
::
::    "%temp%\getadmin.vbs"
::    del "%temp%\\getadmin.vbs"
::    exit /B
::::================================================================================================= end checking admin
:::gotAdmin

cls
echo APP Name    : %mySN%
echo Description : %xDESCEXTRA%
echo .
echo Source      : %xSOURCE%
echo --------------------------------------------------------------------------
echo press any key to continue the installation. (close this windows for cancel)
pause
echo Start process for installing %mySN:~4%
::start /wait "Group Policy Editor Install" powershell.exe -ExecutionPolicy Bypass -File ".\Get Group Policy Editor.ps1"

::dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt 
::dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt 
::for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i" 

wget -OSetup.exe %xDownload%
Setup.exe /install /passive /norestart


::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript
