$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$installDir = $toolsDir

$packageArgs = @{
  packageName    = 'atcmd'
  url            = 'https://cdn.atraining.ru/repo/ATcmd/atcmd-313.zip'
  checksum       = '778ea01582051ed92472a8ce5d35cf01b9aceead473abf90f99f0ed56bcf22f5'
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs
