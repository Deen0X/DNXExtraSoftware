@echo off
%~d0
cd "%~dp0"

set myF=C:\DNXSoftware\Extras\_GetExtras\
set myZIP=%TEMP%\DNXWIN.zip

echo option=%1
pause

if "_%1"=="_/HELLO" goto Hello
if "_%1"=="_/UPDATE" goto updateMe
if "_%1"=="_/ENDUPDATE" goto StartProcess

::There is no parametres, then download and unpack file.
:downloadAndUnpack
::wget -O %temp%\UpdateExtras.cmd "https://raw.githubusercontent.com/Deen0X/DNXWIN/main/_GetExtras/UpdateExtras.cmd"
rmdir /S /Q %Temp%\DNXWin-main
wget -O %myZIP% https://github.com/Deen0X/DNXWIN/archive/refs/heads/main.zip
cd %temp%
7z x -y %myZIP% * %Temp%
::"_Check for Updated Extras.cmd" /UPDATE
cd "%TEMP%\DNXWin-main\_GetExtras"
echo current dir="%TEMP%\DNXWin-main\_GetExtras"
echo im going to run updateextras on temp
pause
UpdateExtras.cmd /UPDATE
echo si estoy viendo esto, entonces no se ha pasado el control a la línea anterior (id 1)
pause
::del /Q UpdateExtras.cmd
goto endScript

:updateMe
::The file was downloaded and un packed
::Running this new instance of the script
echo update me
pause
del /S /Q C:\DNXSoftware\Extras\_GetExtras
xcopy /E /Y %Temp%\DNXWin-main\_GetExtras C:\DNXSoftware\Extras\_GetExtras\
cd %myF%
echo myF=%myF%
"_Check for Updated Extras.cmd" /ENDUPDATE
echo si estoy viendo esto, entonces no se ha pasado el control a la línea anterior (id 2)
pause
goto endScript

:Hello
echo Hello my friend!
pause
goto endScript

:StartProcess
echo Now, this script must navigate into all directories and run each subscript, for adding new options to _Get Extras menu.
pause


:endScript

