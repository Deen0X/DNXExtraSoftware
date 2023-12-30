@echo off
cd /d "%~dp0"
pushd "%~dp0"
set mySP=%~dp0
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion

:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=C:\1DNXSoftware\Extras\GameSaveManager\gs_mngr_3.exe"
::#################################################################################################
set xDESCEXTRA=Starting in Windows 8, the OS comes without the classic Windows 7 games. They are no longer included with Windows 11, Windows 10 and Windows 8.1. Here is a Windows 7 Games package which solves this issue. This Windows 7 Games package is compatible with all builds of Windows 11, Windows 10, Windows 8.1 and Windows 8.
::#################################################################################################
set xSOURCE=https://win7games.com/
::#################################################################################################
set "xDownload=https://drive.usercontent.google.com/download?id=1QORSGwlHuB4iHzw1iom82eZiIrJjZRF1&export=download&authuser=0&confirm=t&uuid=a4299e81-927e-4221-95b9-e7d6e8b7a2b7&at=APZUnTXm2-Nn9udyyQ67mo97aZO6:1703978280927"
::#################################################################################################
set "auxNameExt=Windows7Games_for_Windows_11_10_8.exe"

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

wget --no-check-certificate -O%auxNameExt% "%xDownload%"
echo Installing. You can check installed games on Windows Start Menu - Games
%auxNameExt% /S
rundll32 url.dll,FileProtocolHandler %xSOURCE%


::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript
ie4uinit.exe -show
