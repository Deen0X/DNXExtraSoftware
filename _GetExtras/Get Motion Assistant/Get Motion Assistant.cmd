@echo off
cd /d "%~dp0"
set myP=%~dp0
pushd "%myP%"
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion

:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=C:\Program Files\Motion Assistant\MotionAssistant.exe"
::#################################################################################################
set xDESCEXTRA=MotionAssistant is a gyro data simulation tool that can receive a variety of gyro data inputs and simulate different motion functions, which are used for game-assisted viewing angle aiming, as well as the native somatosensory of the simulator. The analog output methods are: mouse movement, Xbox grip joystick movement, DS4 grip native sensor.
::#################################################################################################
set xSOURCE=Baidu. Using alternative download link (DNX Github)
::Original Link: https://pan.baidu.com/s/1DTAAk3EmEj3crtxacR9MgA?pwd=0kix#list/path=%2Fsharelink3926352113-392076150813444%2F%E4%BD%93%E6%84%9F%E5%8A%A9%E6%89%8B&parentPath=%2Fsharelink3926352113-392076150813444
::#################################################################################################
set xDownload=https://github.com/Deen0X/DNXWIN_ALTDOWNLOADS/raw/main/MotionAssistant/MotionAssistant_Setup_1191.msi
::#################################################################################################

if "_%1"=="_/GETEXTRA" goto getExtra
if "_%1"=="_/ADDMENU" goto addEntry2
goto addEntry

::https://github.com/Deen0X/DNXWIN/blob/main/_AltDownloads/MotionAssistant/MotionAssistant_Setup_1191.msi
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
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\\getadmin.vbs"
    set params = %*:"="
    ::echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c  %~s0 %1 %2 %3", "", "runas", 1 >> "%temp%\\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\\getadmin.vbs"
    exit /B
::================================================================================================= end checking admin
:gotAdmin

cls
echo APP Name    : %mySN%
echo Description : %xDESCEXTRA%
echo .
echo Source      : %xSOURCE%
echo --------------------------------------------------------------------------
echo press any key to continue the installation. (close this windows for cancel)
pause
wget -OSetup.msi %xDownload%
echo Start process for installing %mySN:~4%
Setup.msi /quiet
echo Copying config
cd "Motion Assistant"
call DNXSoft.cmd
cd "%myP%"

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
