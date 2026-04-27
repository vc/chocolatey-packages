$ErrorActionPreference = 'Stop'

$scriptPath = Join-Path $PSScriptRoot "install_latest.ps1"

& $scriptPath -uninstall 'uninstall'