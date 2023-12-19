@echo off
cd /d "%~dp0"
pushd "%~dp0"
xcopy /Y /E ".\DriveC\*.*" "C:\"
xcopy /Y /E ".\User\*.*" "%USERPROFILE%\"
