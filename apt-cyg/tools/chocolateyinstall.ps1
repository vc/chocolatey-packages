$ErrorActionPreference = 'Stop'

$scriptPath = Join-Path $PSScriptRoot 'apt-cyg'

if (-not (Test-Path $scriptPath)) {
    throw "apt-cyg script not found in tools folder"
}

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
    throw 'Cygwin installation not found. Please install Cygwin first.'
}

Write-Host "Cygwin root: $cygwinRoot" -ForegroundColor Cyan

$binDir = Join-Path $cygwinRoot 'bin'
$aptCygPath = Join-Path $binDir 'apt-cyg'

if (-not (Test-Path $binDir)) {
    New-Item -ItemType Directory -Path $binDir -Force | Out-Null
}

$bashExe = Join-Path $cygwinRoot 'bin\bash.exe'
if (Test-Path $bashExe) {
    Write-Host 'Installing apt-cyg to /bin/apt-cyg...' -ForegroundColor Cyan
    $toolsDir = Split-Path $scriptPath -Parent
    cd $toolsDir
    & $bashExe -c "install ./apt-cyg /bin"
} else {
    throw 'Cygwin bash.exe not found at ${cygwinRoot}\bin.'
}

$requiredPackages = @('wget', 'ca-certificates', 'gnupg', 'libiconv')
$missingPackages = @()

$installedDbPath = Join-Path $cygwinRoot 'etc\setup\installed.db'
if (Test-Path $installedDbPath) {
    Write-Host 'Checking for required Cygwin packages...' -ForegroundColor Cyan
    
    $installedDbContent = Get-Content $installedDbPath -ErrorAction SilentlyContinue
    if ($installedDbContent) {
        foreach ($pkg in $requiredPackages) {
            $escapedPkg = [regex]::Escape($pkg)
            $found = $installedDbContent | Where-Object { $_ -match "^${escapedPkg}(\s|\.)" }
            if (-not $found) {
                $missingPackages += $pkg
            }
        }
    }
}

if ($missingPackages.Count -gt 0) {
    Write-Warning "Missing packages: $($missingPackages -join ', ')"
    Write-Warning 'These packages are required for apt-cyg to work properly.'
    Write-Warning 'Install them via Cygwin setup or apt-cyg.'
}

Write-Host 'apt-cyg has been installed successfully!' -ForegroundColor Green
Write-Host "Use 'apt-cyg install <package>' to install Cygwin packages." -ForegroundColor Green