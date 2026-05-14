$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$scriptPath = Join-Path $toolsDir "install_latest.ps1"

Get-ChocolateyWebFile -PackageName 'ipban' `
  -Url 'https://raw.githubusercontent.com/DigitalRuby/IPBan/master/IPBanCore/Windows/Scripts/install_latest.ps1' `
  -fileFullPath $scriptPath `
  -Checksum '960F0D6E20B2AA8326A3E9FE5AF248C722267815DAAE983C01407F804E5C3C35' `
  -ChecksumType 'sha256'

& $scriptPath -silent $true -autostart $true -startupType 'delayed-auto'