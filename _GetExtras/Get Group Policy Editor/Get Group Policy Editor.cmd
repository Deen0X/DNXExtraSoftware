@echo off
cd /d "%~dp0"
pushd "%~dp0"
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion

:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=C:\Windows\System32\gpedit.msc"
::#################################################################################################
set xDESCEXTRA=Chocolatey is a machine-level, command-line package manager and installer for software on Microsoft Windows. It uses the NuGet packaging infrastructure and Windows PowerShell to simplify the process of downloading and installing software.
::#################################################################################################
set xSOURCE=https://www.majorgeeks.com/content/page/enable_group_policy_editor_in_windows_10_home_edition.html
::#################################################################################################
set xDownload1=https://gist.github.com/lelegard/8da0b20cc35708852c14fcf899651204
set xDownload=https://files1.majorgeeks.com/10afebdbffcd4742c81a3cb0f6ce4092156b4375/system/add_gpedit_msc.zip
::#################################################################################################

if "_%1"=="_/ADDMENU" goto addEntry2
if "_%1"=="_/GETEXTRA" goto getExtra
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
echo Start process for installing %mySN:~4%
::start /wait "Group Policy Editor Install" powershell.exe -ExecutionPolicy Bypass -File ".\Get Group Policy Editor.ps1"

::dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt 
::dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt 
::for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i" 

wget -Oadd_gpedit_msc.zip %xDownload%
C:\DNXSoftware\Extras\_GetExtras\7z x -o"%~dp0" add_gpedit_msc.zip
setup.exe
call gpedit-enabler.bat
xcopy /E /Y C:\Windows\SysWOW64\GroupPolicy\ C:\Windows\System32\
xcopy /E /Y C:\Windows\SysWOW64\GroupPolicyUsers\ C:\Windows\System32\
copy C:\Windows\SysWOW64\gpedit.msc C:\Windows\System32\
start "Group Policy" C:\Windows\System32\gpedit.msc


::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript
