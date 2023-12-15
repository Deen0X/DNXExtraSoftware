@echo off
cd /d "%~dp0"
pushd "%~dp0"
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion

:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA="C:\DNXSoftware\ALLINONE_Runtimes.txt""
::#################################################################################################
set xDESCEXTRA=The "All in One Runtimes" package bundles all important runtime packages that are necessary to ensure that all programs will work smoothly and it will installs them automatically also.
::#################################################################################################
set xSOURCE=https://www.updatestar.com/en/directdownload/all-in-one-runtimes/2520652#google_vignette
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
echo .
echo NOTE: the original source is https://www.sereby.org/site/All%20in%20One%20Runtimes
echo but the download link is dynamic and can´t be used directly on this script.
echo for this reason i found an alternative download link to use.
echo --------------------------------------------------------------------------
::echo Note that becuase its difficult to check if this program was installed on the system, i will remove the entry on "Extras Software"
::echo If you want to re-launch this script, please re-run "C:\DNXSoftware\Extras\_GetExtras\Get AllInOne Runtimes\GetAllInOne Runtimes.cmd"
echo press any key for continue installation.
pause
echo Start process for installing %mySN:~4%
wget -Oaioruntime.exe http://static.updatestar.net/dl/allinone/aio-runtimes_v2.5.0.exe
aioruntime.exe
echo installed >"C:\DNXSoftware\ALLINONE_Runtimes.txt"
::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript
