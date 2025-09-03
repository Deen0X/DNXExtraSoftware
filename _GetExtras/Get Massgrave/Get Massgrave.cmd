rem @echo off
cd /d "%~dp0"
pushd "%~dp0"
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion
set NL=^

:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=C:\DNXSoftware\Extras\Massgrave\Massgrave.cmd"
::#################################################################################################
set xDESCEXTRA=Microsoft Activation Scripts (MAS).
::#################################################################################################
set xSOURCE=https://massgrave.dev/
::#################################################################################################
set xDownload=.

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
pause
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
echo --------------------------------------------------------------------------
echo press any key to continue the installation. (close this windows for cancel)
pause


mkdir "C:\DNXSoftware\Extras\Massgrave"
echo powershell -Command "iex (curl.exe -s --doh-url https://1.1.1.1/dns-query https://get.activated.win | Out-String)">"%checkEXTRA%"
start %checkEXTRA% 
::echo Start process for installing %mySN:~4%
::wget --no-check-certificate -Owsa.7z "https://github.com/MustardChef/WSABuilds/releases/download/Windows_10_2308.40000.3.0/WSA_2308.40000.3.0_x64_Release-Nightly-MindTheGapps-13.0-RemovedAmazon_Windows_10.7z"
::C:\DNXSoftware\Extras\_GetExtras\7z x  -oC:\DNXSoftware\Extras wsa.7z
::del wsa.7z
::ren C:\DNXSoftware\Extras\WSA_2308.40000.3.0_x64 WSA
::C:
::cd C:\DNXSoftware\Extras\WSA\
::start "WSA First Run" "C:\DNXSoftware\Extras\WSA\run.bat"


::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript