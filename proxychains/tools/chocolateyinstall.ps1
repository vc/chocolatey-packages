$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = $toolsDir

$cygwinDetected = $false
$cygwinRoot = $null

$localKey = 'HKLM:\SOFTWARE\Cygwin\setup'
$localKey6432 = 'HKLM:\SOFTWARE\Wow6432Node\Cygwin\setup'

$cygwinRoot = @($localKey, $localKey6432) | Where-Object { Test-Path $_ } | ForEach-Object { 
    Get-ItemProperty -Path $_ -ErrorAction SilentlyContinue | Select-Object -ExpandProperty rootdir 
}

if ($cygwinRoot -ne $null -and $cygwinRoot -ne '') {
    $cygwinDetected = $true
    Write-Host "Cygwin found in registry: $cygwinRoot"
} else {
    if (Test-Path 'c:\tools\cygwin') {
        $cygwinRoot = 'c:\tools\cygwin'
        $cygwinDetected = $true
        Write-Host "Cygwin found in default path: $cygwinRoot"
    }
}

if ($cygwinDetected) {
    Write-Host "Cygwin detected - installing Cygwin build"
    $url = "https://github.com/shunf4/proxychains-windows/releases/download/0.6.8/proxychains_0.6.8_cygwin_x64.zip"
    $checksum = "4E6E42FE39B57F5277A9701CC750726F93D12E4CCECCFBC0491C71DF2C88664D"
} else {
    Write-Host "Cygwin not detected - installing Win32 build"
    $url = "https://github.com/shunf4/proxychains-windows/releases/download/0.6.8/proxychains_0.6.8_win32_x64.zip"
    $checksum = "14534208F85F0DEE5B4E0B3700CE19FDCAE86648D43FC2C70CD3117E140FE1EF"
}

$packageArgs = @{
    packageName    = 'proxychains'
    url            = $url
    checksum       = $checksum
    checksumType   = 'sha256'
    unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs

if ($cygwinDetected) {
    Rename-Item "$installDir\proxychains_cygwin_x64.exe" "proxychains.exe" -ErrorAction SilentlyContinue
    Rename-Item "$installDir\proxychains_helper_cygwin_x64.exe" "proxychains_helper.exe" -ErrorAction SilentlyContinue
} else {
    Rename-Item "$installDir\proxychains_win32_x64.exe" "proxychains.exe" -ErrorAction SilentlyContinue
    Rename-Item "$installDir\proxychains_helper_win32_x64.exe" "proxychains_helper.exe" -ErrorAction SilentlyContinue
}

$currentPath = [Environment]::GetEnvironmentVariable('PATH', 'Machine')
$newPath = if ($currentPath -ne $null) { "$currentPath;$installDir" } else { $installDir }
[Environment]::SetEnvironmentVariable('PATH', $newPath, 'Machine')
$env:Path = "$env:Path;$installDir"