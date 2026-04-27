$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$files = @(
    "$toolsDir\atcmd.exe"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        Remove-Item $file -Force
    }
}