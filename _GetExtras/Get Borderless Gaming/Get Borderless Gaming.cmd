@echo off
cd /d "%~dp0"
pushd "%~dp0"
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion

:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=C:\Program Files (x86)\Borderless Gaming\BorderlessGaming.exe"
::#################################################################################################
set xDESCEXTRA=Borderless Gaming is a simple tool that will allow you to turn your windowed video games into "fullscreen" applications without all of the negative side effects
::#################################################################################################
set xSOURCE=https://github.com/Codeusa/Borderless-Gaming
::#################################################################################################
set xDownload=https://github.com/Codeusa/Borderless-Gaming/releases/download/9.5.6/BorderlessGaming9.5.6_admin_setup.exe
::#################################################################################################

if "_%1"=="_/GETEXTRA" goto getExtra
if "_%1"=="_/ADDMENU" goto addEntry2
goto addEntry


:addEntry
::================================================================================================= Check if EXTRA exist
echo "%checkEXTRA%"
if exist "%checkEXTRA%" goto removeEntry
::------------------------------------------------------------------------------------------------- Add Entry if not exist
:addEntry2
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

wget --no-check-certificate -OSetup.exe %xDownload%
Setup.exe /verysilent
cd "C:\Program Files (x86)\Borderless Gaming"
C:
Start "%mySN:~4%" "%checkEXTRA%"

::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript
