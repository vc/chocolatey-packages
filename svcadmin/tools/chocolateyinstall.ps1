$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

#$pp = Get-PackageParameters
$installDir = $toolsDir
#if ($pp.InstallDir -or $pp.InstallationPath ) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
#Write-Host "Sysinternals Suite is going to be installed in '$installDir'"

$packageArgs = @{
  packageName    = 'svcadmin'
  url            = 'https://rsdn.org/article/baseserv/svcadmin-1/svcadmin.zip'
  checksum       = 'f04ee7bc0179b688d4cf31be9ec23a14fa4a5bb60b0a0a7b10f0c2c4b9e0165c'
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs
