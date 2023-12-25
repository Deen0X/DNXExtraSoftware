@echo off
cd /d "%~dp0"
pushd "%~dp0"
set myP=%~dp0
set mySN=%~n0
setlocal enableextensions disabledelayedexpansion
set driveExtract=C:
if exist D:\ set driveExtract=D:
:: ALL scripts must start with "GET " text
::################################################################################################# Config variable for checking if Extra is installed
set "checkEXTRA=%driveExtract%\BOBWIN_Lite\BOBWin.exe"
::#################################################################################################
set xDESCEXTRA=Retro games. Many. PS2, Gamecube, Megadrive, Specter, Amstrad, PinballFX. Some can be played against another person even if they are not together, over the internet. One acts as host and another (or others) acts as players or spectators.
::#################################################################################################
set xSOURCE=https://t.me/BOB_retropie_windows_dudas/310867
::#################################################################################################
set "xDownload=https://drive.usercontent.google.com/download?id=18DrVov7DL8KQOvE3IbSFnrNUve1Nszrj&export=download&authuser=0&confirm=t&uuid=4abcbb4b-8950-4bb8-860d-11a97dec12d8&at=APZUnTVLoS-sqxqicYhqKmP26zPF:1703516461904"
::#################################################################################################
set "auxNameExt=BOBWinLite.7z"
set "auxName=Chiaki.exe"

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

cls
echo APP Name    : %mySN%
echo Description : %xDESCEXTRA%
echo .
echo Source      : %xSOURCE%
echo --------------------------------------------------------------------------
echo press any key to continue the installation. (close this windows for cancel)
pause
***********************
echo .
echo .
echo .
echo NOTE:
echo This procedure will download a large file (2GB aprox).
echo This will need additional 4.5GB aprox for un compress on %driveExtract% drive
echo if you are not sure about doing this, close this window right now.
pause
echo .
echo .
echo .
echo while downloading the file, you can check the page of the project for general information. The page will be automatically opened.
pause
echo .
echo .
echo .
echo Start process for installing %mySN:~4%
echo Downloading Large File (2GB) and opening webpage...
rundll32 url.dll,FileProtocolHandler https://telegra.ph/Manual-BOBwin-09-21
wget -O%auxNameExt% "%xDownload%"
C:\DNXSoftware\Extras\_GetExtras\7z x -pDNXBOBWIN -y -o%driveExtract% %auxNameExt%
call "C:\DNXSoftware\Extras\_GetExtras\createlnk.cmd" "%driveExtract%\BOBWIN_Lite\BOBWin.exe" "%driveExtract%\BOBWIN_Lite" "%mySN:~4%" "" "%driveExtract%\BOBWIN_Lite\BOBWin.exe"
move "%driveExtract%\BOBWIN_Lite\%mySN:~4%.lnk" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\_DNXSoftware\"
copy "%MyP%BOBWin Keyboard.png" "%driveExtract%\BOBWIN_Lite\BOBWin Keyboard.png"
start "BOBWin" "%driveExtract%\BOBWIN_Lite\BOBWin.exe"
::------------------------------------------------------------------------------------------------- Remove Entry Extra was installed
echo %checkEXTRA%
if exist "%checkEXTRA%" goto removeEntry
goto endScript


::================================================================================================= End Script
:endScript
