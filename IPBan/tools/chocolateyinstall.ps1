$ErrorActionPreference = 'Stop'

$scriptPath = Join-Path $PSScriptRoot "install_latest.ps1"

& $scriptPath -silent $true -autostart $true -startupType 'delayed-auto'