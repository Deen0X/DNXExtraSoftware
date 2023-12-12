@echo off
cd /d "%~dp0"
pushd "%~dp0"
::Coded by DNX
:CreateShortCut sDest sPath sTitle sArgs sIcon sINum :{
setlocal enableextensions enabledelayedexpansion
set bDebug=0
	set sDest=%~1
	set sPath=%~2
	set sTitle=%~3
	set sArgs=%~4
	set sIcon=%~5
	set sWork=%~dp1
	set SCRIPT="%TEMP%\DNSPScriptCreateSC-%RANDOM%%RANDOM%%RANDOM%%RANDOM%.vbs"

	call :checkDIRF "%sPath%" sPath

	if %bDebug%==4 (
		echo * sDest      =%sPath%
		echo * sPath      =%sPath%
		echo * sTitle     =%sTitle%
		echo * sArgs      =%sArgs%
		echo * sIcon      =%sIcon%
		echo * sWork      =%sWork%
		echo * SCRIPT     =%SCRIPT%
	)
	
rem Creating File	
	echo Set oWS = WScript.CreateObject("WScript.Shell") > %SCRIPT%
	echo sLinkFile = "%sPath%%sTitle%.lnk" >> %SCRIPT%
	echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
	echo oLink.TargetPath = "%sDest%" >> %SCRIPT%
	echo oLink.Arguments = "%sArgs%" >> %SCRIPT%
	echo oLink.WorkingDirectory = "%sWork%" >> %SCRIPT%
	echo oLink.IconLocation = "%sIcon%" >> %SCRIPT%
	echo oLink.Save >> %SCRIPT%
	cscript /nologo %SCRIPT%
	del %SCRIPT%
(
endlocal
exit /b
)
:}

:: __________________________________________________________________ checkDIRF
:: check if the argument (must be an directory) ends with "\"
:checkDIRF strVar {outVar} :{
setlocal enableextensions enabledelayedexpansion
	set mySV=%~1
	call :strLen "%mySV%" mySVLen
	rem start counting from zero
 	set /a mySVLen=%mySVLen%-1
	set mySVLen=%mySVLen%
	call set myLL=%%mySV:~%mySVLen%,1%%%
	if "_%myLL%" NEQ "_\" (
		set sRC=%mySV%\
	) else (
		set sRC=%mySV%
	)
(
	endlocal
	set %2=%sRC%
	exit /b
)
:}

:: __________________________________________________________________ Sub strLen
:: Get the lenght of a string
:strLen strVar {outVar} :{
(   
    setlocal EnableDelayedExpansion
    rem (set^ xtmp="!%~1!")
	set "xtmp=%~1"
rem 	echo var1=%1
rem 	echo var1b=%~1
rem 	echo xtmp=!xtmp!
rem 	pause
    if defined xtmp (
        set "len=1"
        for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
            if "!xtmp:~%%P,1!" NEQ "" ( 
                set /a "len+=%%P"
                set "xtmp=!xtmp:~%%P!"
            )
        )
    ) ELSE (
        set len=0
    )
)
( 
    endlocal
    set "%~2=%len%"
    exit /b
)
:}
