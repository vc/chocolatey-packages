$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$installDir = $toolsDir

$chocoBin = "$env:ChocolateyInstall\bin"
$env:PATH = "$chocoBin;$env:PATH"

$url = 'https://cdn.atraining.ru/repo/ATcmd/atcmd-313.zip'
$checksum = '778ea01582051ed92472a8ce5d35cf01b9aceead473abf90f99f0ed56bcf22f5'
$zipPath = "$env:TEMP\atcmd_temp.zip"

& "$chocoBin\curl.exe" -sL -o $zipPath $url
if ($LASTEXITCODE -ne 0) {
    throw "Download failed with exit code $LASTEXITCODE"
}

$hash = Get-FileHash -Path $zipPath -Algorithm SHA256
if ($hash.Hash -ne $checksum) {
    Remove-Item $zipPath -Force
    throw "Checksum mismatch. Expected: $checksum, Actual: $($hash.Hash)"
}

Expand-Archive -Path $zipPath -DestinationPath $installDir -Force
Remove-Item $zipPath -Force