$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Uninstall-ChocolateyPath -PathToRemove $toolsDir -Scope 'Machine'