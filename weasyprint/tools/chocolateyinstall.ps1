$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName   = 'weasyprint'
    url           = 'https://github.com/Kozea/WeasyPrint/releases/download/v69.0/weasyprint-windows.zip'
    checksum      = '330101ff3ea50ebde4abf805283b6d703d5f3d71c77c983db94357ec4524a3ef'
    checksumType  = 'sha256'
    unzipLocation = $toolsDir
}
Install-ChocolateyZipPackage @packageArgs
