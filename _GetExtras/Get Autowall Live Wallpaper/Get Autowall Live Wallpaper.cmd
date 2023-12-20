@echo off
cd /d "%~dp0"
pushd "%~dp0"
set "mySP=%~dp0"
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion
:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=C:\1DNXSoftware\Extras\Autowall\Autowall.exe"
::#################################################################################################
set xDESCEXTRA=Turn videos, gifs and webs into windows live wallpapers. The most simple and useful Weebp implementation in autoit.
::#################################################################################################
set xSOURCE=https://github.com/SegoCode/AutoWall
::#################################################################################################
set xDownload=https://github.com/SegoCode/AutoWall/releases/download/1.11/AutoWall.zip
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

::wget -OAutoWall.zip %xDownload%
C:\DNXSoftware\Extras\_GetExtras\7z x -y -oC:\DNXSoftware\Extras AutoWall.Zip
::copy "%mySN:~4%.ico" "C:\DNXSoftware\Extras\AutoWall\AutoWall.ico"
call "C:\DNXSoftware\Extras\_GetExtras\createlnk.cmd" "C:\DNXSoftware\Extras\AutoWall\AutoWall.exe" "C:\DNXSoftware\Extras\AutoWall" "%mySN:~4%" "" "C:\DNXSoftware\Extras\AutoWall\AutoWall.exe"

copy "%mySP%\AutoWall Youtube Example.lnk" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\AutoWall.lnk"
copy "%mySP%\AutoWall Youtube Example.lnk" "C:\DNXSoftware\Extras\AutoWall\"
copy "%mySP%\AutoWall Stop.lnk" "C:\DNXSoftware\Extras\AutoWall\"
copy "%mySP%\AutoWall Stop.cmd" "C:\DNXSoftware\Extras\AutoWall\"
copy "%mySP%\AutoWall Refresh.cmd" "C:\DNXSoftware\Extras\AutoWall\"
copy "%mySP%\AutoWall Refresh.lnk" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware\"
copy "%mySP%\AutoWall Stop.lnk" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware\"
call "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\AutoWall.lnk"

::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript
