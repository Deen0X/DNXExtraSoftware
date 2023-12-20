@echo off
cd /d "%~dp0"
pushd "%~dp0"
set mySP=%~dp0
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion

:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=C:\DNXSoftware\Extras\GameSaveManager\gs_mngr_3.exe"
::#################################################################################################
set xDESCEXTRA=GameSave Manager fixes this problem by automatically detecting the location of your savegames. It can then backup the files into an archive, and then restore them on another computer. It does all this using a very well kept savegames database, where the userbase share custom savegame entries for newly released games.
::#################################################################################################
set xSOURCE=https://www.gamesave-manager.com/
::#################################################################################################
set xDownload=https://www.gamesave-manager.com/file/1736495a-99fc-4be6-89f5-b1853ec30c4c/
set xDownloadDB=https://www.gamesave-manager.com/download/788c0aeb-c3c6-4750-936e-47af65249163/
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

curl -L %xDownload% --output GSM.zip
C:\DNXSoftware\Extras\_GetExtras\7z x -y -oC:\DNXSoftware\Extras\GameSaveManager GSM.Zip
curl -L %xDownloadDB% --output db-update.gsdu
xcopy /E /Y Settings\* C:\DNXSoftware\Extras\GameSaveManager\Settings\
::Ignoring some entries that take long time on load
"C:\DNXSoftware\Extras\GameSaveManager\gs_mngr_3.exe" "/ignore Playnite" -s
echo Updating database...
start "GameSaveMAnager" "C:\DNXSoftware\Extras\GameSaveManager\gs_mngr_3.exe" """/update "%mySP%\db-update.gsdu""""
call "C:\DNXSoftware\Extras\_GetExtras\createlnk.cmd" "C:\DNXSoftware\Extras\GameSaveManager\gs_mngr_3.exe" "C:\DNXSoftware\Extras\GameSaveManager" "%mySN:~4%" "/GETEXTRA" "C:\DNXSoftware\Extras\GameSaveManager\gs_mngr_3.exe"
copy "C:\DNXSoftware\Extras\GameSaveManager\%mySN:~4%.lnk" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware\"
::copy "Get Chiaki Playstation Streaming.ico" "C:\DNXSoftware\Extras\Chiaki\Chiaki.ico"
::call "C:\DNXSoftware\Extras\_GetExtras\createlnk.cmd" "C:\DNXSoftware\Extras\Chiaki\Chiaki.exe" "C:\DNXSoftware\Extras\Chiaki" "%mySN:~4%" "/GETEXTRA" "C:\DNXSoftware\Extras\Chiaki\Chiaki.ico"
::move "C:\DNXSoftware\Extras\Chiaki\%mySN:~4%.lnk" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware\"


::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript
ie4uinit.exe -show
