@echo off
cd /d "%~dp0"
pushd "%~dp0"
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion

:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=C:\Program Files\Winaero Tweaker\WinaeroTweaker.exe"
::#################################################################################################
set xDESCEXTRA= It is an all-in-one application that comes with dozens of options for fine-grained tuning of various Windows settings and features.
::#################################################################################################
set xSOURCE=https://winaerotweaker.com/
::#################################################################################################
set xDownload=https://winaerotweaker.com/download/winaerotweaker.zip
::#################################################################################################
set "auxNameExt=Winaerotweaker.zip"
set "auxName=WinaeroTweakerSetup.exe"

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

wget --no-check-certificate -O%auxNameExt% %xDownload%
C:\DNXSoftware\Extras\_GetExtras\7z x -y -OAuxExt %auxNameExt%
ren ".\AuxExt\WinaeroTweaker*.exe" %auxName%
start "%mySN:~4%" /B /WAIT ".\AuxExt\%auxName%" /SP- /VERYSILENT
::PAUSE
::call "C:\DNXSoftware\Extras\_GetExtras\createlnk.cmd" "C:\DNXSoftware\Extras\%auxName%\%auxNameExt%" "C:\DNXSoftware\Extras\%auxName%" "%mySN:~4%" "/GETEXTRA" "C:\DNXSoftware\Extras\%auxName%\%auxNameExt%"
::move "C:\DNXSoftware\Extras\%auxName%\%mySN:~4%.lnk" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware\"
start "WinAero Tweaker" "%checkEXTRA%"

::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript
