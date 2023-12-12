@echo off
%~d0
cd "%~dp0"

set myF=C:\DNXSoftware\Extras\_GetExtras\
set myZIP=%TEMP%\DNXWIN.zip

if "%1_"=="/UPDATE" goto updateMe
if "%1_"=="/ENDUPDATE" goto StartProcess

::There is no parametres, then download and unpack file.
:downloadAndUnpack
::wget -O %temp%\UpdateExtras.cmd "https://raw.githubusercontent.com/Deen0X/DNXWIN/main/_GetExtras/UpdateExtras.cmd"
wget -O %myZIP% https://github.com/Deen0X/DNXWIN/archive/refs/heads/main.zip
cd %temp%
7z x %myZIP% * %Temp%
UpdateExtras.cmd /UPDATE
echo si estoy viendo esto, entonces no se ha pasado el control a la línea anterior (id 1)
pause
::del /Q UpdateExtras.cmd
goto endScript

:updateMe
::The file was downloaded and un packed
::Running this new instance of the script
del /S /Q C:\DNXSoftware\Extras\_GetExtras
xcopy /E /Y %Temp%\DNXWin-main\_GetExtras C:\DNXSoftware\Extras\_GetExtras\
cd %myF%
_Check for Updated Extras.cmd /ENDUPDATE
echo si estoy viendo esto, entonces no se ha pasado el control a la línea anterior (id 2)
pause
goto endScript

:StartProcess
echo Now, this script must navigate into all directories and run each subscript, for adding new options to _Get Extras menu.
pause


:endScript
