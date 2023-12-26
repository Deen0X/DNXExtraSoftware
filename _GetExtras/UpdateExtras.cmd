 @echo off
::Script created by:Deen0X
::part of DNXWIN Project
set GENPARAM=%2
%~d0
set myPath=%~dp0
cd "%myPath%"

if not exist "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware"

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

if not exist "C:\Windows\System32\wget.exe" (
    ::Download wget to system32, for get this on general path for running directly.
    curl --output %SystemRoot%\System32\wget.exe -L https://eternallybored.org/misc/wget/1.21.4/64/wget.exe
)

set myF=C:\DNXSoftware\Extras\_GetExtras\
set myZIP=%TEMP%\DNXEXTRASOFT.zip

::goto StartProcess

if "_%1"=="_/UPDATE" goto updateMe
if "_%1"=="_/ENDUPDATE" goto StartProcess

::There is no parametres, then download and unpack file.
:downloadAndUnpack
rmdir /S /Q %Temp%\DNXExtraSoftware-main
wget -O %myZIP% https://github.com/Deen0X/DNXExtraSoftware/archive/refs/heads/main.zip
cd %temp%
start "Unzip" /WAIT /MIN powershell -command "Expand-Archive '%MyZIP%' '%Temp%'"
del "%MyZIP%"
::7z x -y %myZIP% * %Temp%
cd "%TEMP%\DNXExtraSoftware-main\_GetExtras"
UpdateExtras.cmd /UPDATE %GENPARAM%
goto endScript

:updateMe
::The file was downloaded and un packed
::Running this new instance of the script
rmdir /S /Q "C:\DNXSoftware\Extras\_GetExtras" >nul
xcopy /E /Y "%Temp%\DNXExtraSoftware-main\_GetExtras" "C:\DNXSoftware\Extras\_GetExtras\" >nul
cd %myF%
ren UpdateExtras.cmd "_Check for Updated Extras.cmd" >nul
echo ============================================================================================================= Create Main Entry
if not exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\_Extra Software" mkdir "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\_Extra Software"
if not exist "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_Extra Software\" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_Extra Software\"

::CREAR LINK
echo on
set "myICO=C:\DNXSoftware\Extras\_GetExtras\DNXEXTRAS.ico"
call "C:\DNXSoftware\Extras\_GetExtras\createlnk.cmd" "C:\DNXSoftware\Extras\_GetExtras\_Check for Updated Extras.cmd" "C:\DNXSoftware\Extras\_GetExtras\" "_Check for Updated Extras" "" "%myICO%"
move "_Check for Updated Extras.lnk" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\_Extra Software\_Check for Updated Extras.lnk" >nul

"_Check for Updated Extras.cmd" /ENDUPDATE %GENPARAM%
goto endScript

:StartProcess
echo =============================================================================================================
echo Start Extras Update
echo Ckecking new entries
echo =============================================================================================================
rmdir /S /Q "%TEMP%\DNXWin-main"
FOR /D %%G in ("%myF%*") do call :checkFolder "%%G"
cd %myP%
goto endScript

:checkFolder
set "mySubS=%~n1"
set "mySubPath=%~1"
echo Checking %mySubS%
call "%mySubPath%\%mySubS%.cmd" %GENPARAM%
exit /b


:endScript
ie4uinit.exe -show
