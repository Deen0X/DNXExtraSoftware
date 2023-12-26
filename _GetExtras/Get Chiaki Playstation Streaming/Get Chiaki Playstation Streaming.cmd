@echo off
cd /d "%~dp0"
pushd "%~dp0"
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion

:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=C:\DNXSoftware\Extras\Chiaki\Chiaki.exe"
::#################################################################################################
set xDESCEXTRA=Chiaki is a Free and Open Source Software Client for PlayStation 4 and PlayStation 5 Remote Play for Linux, FreeBSD, OpenBSD, NetBSD, Android, macOS, Windows, Nintendo Switch and potentially even more platforms.
::#################################################################################################
set xSOURCE=https://git.sr.ht/~thestr4ng3r/chiaki
::#################################################################################################
set xDownload=https://git.sr.ht/~thestr4ng3r/chiaki/refs/download/v2.2.0/Chiaki-v2.2.0-Windows-x86_64.zip
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

wget --no-check-certificate -OChiaki.zip %xDownload%
C:\DNXSoftware\Extras\_GetExtras\7z x -y -oC:\DNXSoftware\Extras\Chiaki Chiaki.Zip
copy "Get Chiaki Playstation Streaming.ico" "C:\DNXSoftware\Extras\Chiaki\Chiaki.ico"
call "C:\DNXSoftware\Extras\_GetExtras\createlnk.cmd" "C:\DNXSoftware\Extras\Chiaki\Chiaki.exe" "C:\DNXSoftware\Extras\Chiaki" "%mySN:~4%" "" "C:\DNXSoftware\Extras\Chiaki\Chiaki.ico"
move "C:\DNXSoftware\Extras\Chiaki\%mySN:~4%.lnk" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware\"
start "%mySN:~4%" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware\%mySN:~4%.lnk"

::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript
