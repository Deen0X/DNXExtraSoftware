@echo off
cd /d "%~dp0"
pushd "%~dp0"
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion

:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=C:\DNXSoftware\Extras\Chiaki4Deck\Chiaki.exe"
::#################################################################################################
set xDESCEXTRA=An open source project looking to help users of the Steam Deck get the most out of Chiaki. Click here to see the accompanying site for documentation, updates and more.
::#################################################################################################
set xSOURCE=https://github.com/streetpea/chiaki4deck
::#################################################################################################
set xDownload=https://github.com/streetpea/chiaki4deck/releases/download/v1.5.0/Chiaki4deck-win_x64-VC-Release.zip
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

wget -OChiaki.zip %xDownload%
C:\DNXSoftware\Extras\_GetExtras\7z x -y -oChiaki4d Chiaki.Zip
C:\DNXSoftware\Extras\_GetExtras\7z x -y -oC:\DNXSoftware\Extras .\Chiaki4d\Chiaki4deck-win_x64-VC-1.4.1.Zip
ren C:\DNXSoftware\Extras\Chiaki4deck-VC Chiaki4deck
copy "Get Chiaki4Deck Playstation Streaming.ico" "C:\DNXSoftware\Extras\Chiaki4Deck\Chiaki4Deck.ico"
call "C:\DNXSoftware\Extras\_GetExtras\createlnk.cmd" "C:\DNXSoftware\Extras\Chiaki4Deck\Chiaki.exe" "C:\DNXSoftware\Extras\Chiaki4Deck" "%mySN:~4%" "" "C:\DNXSoftware\Extras\Chiaki4Deck\Chiaki4Deck.ico"
move "C:\DNXSoftware\Extras\Chiaki4Deck\%mySN:~4%.lnk" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware\"
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Chiaki\Chiaki\settings" /v "auto_discovery" /t REG_SZ /d "true" /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Chiaki\Chiaki\settings" /v "audio_buffer_size" /t REG_DWORD /d 1200 /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Chiaki\Chiaki\settings" /v "codec" /t REG_SZ /d "h264" /f
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Chiaki\Chiaki\settings" /v "log_verbose" /t REG_SZ /d "true" /f
start "%mySN:~4%" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware\%mySN:~4%.lnk"


::Chiaki.zip /install /passive /norestart

::Example unpack
::C:\DNXSoftware\Extras\_GetExtras\7z x  -oC:\DNXSoftware\Extras wsa.7z
::del wsa.7z
::ren C:\DNXSoftware\Extras\WSA_2308.40000.3.0_x64 WSA


::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript
