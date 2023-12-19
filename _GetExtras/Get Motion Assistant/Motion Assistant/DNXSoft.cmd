@echo off
cd /d "%~dp0"
pushd "%~dp0"
setlocal enableextensions disabledelayedexpansion
::Setup File
::MotionAssistant_Setup_1191.msi /quiet

::Copy DriveC Files
xcopy /Y /E ".\DriveC\*.*" "C:\"

::Copy User Path
xcopy /Y /E ".\User\*.*" "%USERPROFILE%\"

::Import Regs
For /R %%f in (.\REGs\*.reg) do (
	reg import "%%f"
)
