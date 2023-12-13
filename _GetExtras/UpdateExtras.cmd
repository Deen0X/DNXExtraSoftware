@echo off
::Script created by:Deen0X
::part of DNXWIN Project
%~d0
set myPath=%~dp0
cd "%myPath%"

::get admin permissions for avoid doing this on subscripts
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


set myF=C:\DNXSoftware\Extras\_GetExtras\
set myZIP=%TEMP%\DNXWIN.zip

::goto StartProcess

if "_%1"=="_/UPDATE" goto updateMe
if "_%1"=="_/ENDUPDATE" goto StartProcess

::There is no parametres, then download and unpack file.
:downloadAndUnpack
::wget -O %temp%\UpdateExtras.cmd "https://raw.githubusercontent.com/Deen0X/DNXWIN/main/_GetExtras/UpdateExtras.cmd"
rmdir /S /Q %Temp%\DNXWin-main
wget -O %myZIP% https://github.com/Deen0X/DNXWIN/archive/refs/heads/main.zip
cd %temp%
7z x -y %myZIP% * %Temp%
cd "%TEMP%\DNXWin-main\_GetExtras"
UpdateExtras.cmd /UPDATE
goto endScript

:updateMe
::The file was downloaded and un packed
::Running this new instance of the script
del /S /Q "C:\DNXSoftware\Extras\_GetExtras" >nul
xcopy /E /Y "%Temp%\DNXWin-main\_GetExtras" "C:\DNXSoftware\Extras\_GetExtras\" >nul
cd %myF%
ren UpdateExtras.cmd "_Check for Updated Extras.cmd" >nul
echo ============================================================================================================= Create Main Entry
if not exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\_Extra Software" mkdir "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\_Extra Software"
if not exist "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_Extra Software\" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_Extra Software\"

::CREAR LINK
echo on
set "myICO=C:\DNXSoftware\Extras\_GetExtras\DNXEXTRAS.ico"
call "C:\DNXSoftware\Extras\_GetExtras\createlnk.cmd" "C:\DNXSoftware\Extras\_GetExtras\_Check for Updated Extras.cmd" "C:\DNXSoftware\Extras\_GetExtras\" "_Check for Updated Extras" "" "%myICO%"
pause
move "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\_Extra Software\_Check for Updated Extras.lnk" 

"_Check for Updated Extras.cmd" /ENDUPDATE
goto endScript

:StartProcess
echo =============================================================================================================
echo Start Extras Update
echo Ckecking new entries
echo =============================================================================================================
del /S /Q "%TEMP%\DNXWin-main\_GetExtras" >nul
FOR /D %%G in (%myF%*) do call :checkFolder "%%G"
goto endScript

:checkFolder
set "mySubS=%~n1"
set "mySubPath=%~1"
echo Checking %mySubS%
call "%mySubPath%\%mySubS%.cmd"
exit /b


:endScript
