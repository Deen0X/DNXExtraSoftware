dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt 
dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt 

for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i" 


#Get-ChildItem @(
#    "C:\Windows\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package*.mum",
#    "C:\Windows\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package*.mum"
#) | ForEach-Object { dism.exe /online /norestart /add-package:"$_" }
