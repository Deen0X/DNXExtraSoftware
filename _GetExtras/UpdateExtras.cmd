@echo off
%~d0
cd "%~dp0"

set myF=C:\DNXSoftware\Extras\_GetExtras\
set myZIP=%TEMP%\DNXWIN.zip

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
del /S /Q C:\DNXSoftware\Extras\_GetExtras
xcopy /E /Y %Temp%\DNXWin-main\_GetExtras C:\DNXSoftware\Extras\_GetExtras\
cd %myF%
ren UpdateExtras.cmd "_Check for Updated Extras.cmd"
"_Check for Updated Extras.cmd" /ENDUPDATE
goto endScript

:StartProcess
echo Now, this script must navigate into all directories and run each subscript, for adding new options to _Get Extras menu.
pause

:endScript

