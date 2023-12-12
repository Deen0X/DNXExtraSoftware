echo "Installing Chocolatey"
Get-PackageProvider -Name chocolatey -Force
Install-Package -Name Chocolatey -Force -ProviderName chocolatey
$chocopath = (Get-Package chocolatey | ?{$_.Name -eq "chocolatey"} | Select @{N="Source";E={((($a=($_.Source -split "\\"))[0..($a.length - 2)]) -join "\"),"Tools\chocolateyInstall" -join "\"}} | Select -ExpandProperty Source)
& $chocopath "upgrade all -y"
choco install chocolatey-core.extension --force
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\_Extra Software\Get Chocolatey.lnk"
