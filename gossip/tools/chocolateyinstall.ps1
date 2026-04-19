$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName    = 'gossip'
    url          = 'https://github.com/mikedilger/gossip/releases/download/v0.14.0/gossip.0.14.0.msi'
    checksum    = 'FAE7063D0E2741EC55CCCC51753ED4C5F9BE374665B25323CF6C31179C4F4736'
    checksumType = 'sha256'
    fileType     = 'msi'
    silentArgs   = '/qn /norestart'
}

Install-ChocolateyPackage @packageArgs