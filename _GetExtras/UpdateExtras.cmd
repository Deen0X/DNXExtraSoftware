@echo off
::Script created by:Deen0X
::part of DNXWIN Project
%~d0
set myPath=%~dp0
cd "%myPath%"
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
del /S /Q C:\DNXSoftware\Extras\_GetExtras >nul
xcopy /E /Y %Temp%\DNXWin-main\_GetExtras C:\DNXSoftware\Extras\_GetExtras\ >nul
cd %myF%
ren UpdateExtras.cmd "_Check for Updated Extras.cmd" >nul
"_Check for Updated Extras.cmd" /ENDUPDATE
goto endScript

:StartProcess
echo =============================================================================================================
echo Start Extras Update
echo Ckecking new entries
echo =============================================================================================================

FOR /D %%G in (%myF%*) do call :checkFolder "%%G"
goto endScript

:checkFolder
set "mySubS=%~n1"
set "mySubPath=%~1"
echo Checking %mySubS%
call "%mySubPath%\%mySubS%.cmd"
exit /b


:endScript
pause
