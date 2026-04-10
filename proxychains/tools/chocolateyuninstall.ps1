$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$machinePath = [Environment]::GetEnvironmentVariable('PATH', 'Machine')
if ($machinePath -ne $null -and $machinePath -like "*$toolsDir*") {
    $pathArray = $machinePath -split ';' | Where-Object { $_ -ne '' -and $_ -ne $toolsDir }
    $newMachinePath = $pathArray -join ';'
    [Environment]::SetEnvironmentVariable('PATH', $newMachinePath, 'Machine')
}