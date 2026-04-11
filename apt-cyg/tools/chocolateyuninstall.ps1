$ErrorActionPreference = 'Stop'

$cygwinRoot = $null

if (Test-Path 'HKLM:\SOFTWARE\Cygwin\setup') {
    $cygwinRoot = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Cygwin\setup' -Name 'rootdir' -ErrorAction SilentlyContinue
    if ($cygwinRoot) {
        $cygwinRoot = $cygwinRoot.rootdir
    }
}

if (-not $cygwinRoot) {
    $possiblePaths = @('C:\tools\cygwin', 'C:\cygwin64', 'C:\cygwin', "${env:ProgramFiles}\Cygwin", "${env:ProgramFiles(x86)}\Cygwin")
    foreach ($path in $possiblePaths) {
        if (Test-Path $path) {
            $cygwinRoot = $path
            break
        }
    }
}

if (-not $cygwinRoot -or -not (Test-Path $cygwinRoot)) {
    Write-Warning 'Cygwin installation not found. Nothing to remove.'
    exit 0
}

$aptCygPath = Join-Path $cygwinRoot 'bin\apt-cyg'
if (Test-Path $aptCygPath) {
    Write-Host "Removing apt-cyg from $aptCygPath..." -ForegroundColor Cyan
    Remove-Item -Path $aptCygPath -Force
    Write-Host 'apt-cyg has been removed.' -ForegroundColor Green
} else {
    Write-Host 'apt-cyg is not installed. Nothing to remove.' -ForegroundColor Yellow
}