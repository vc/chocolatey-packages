# Chocolatey Packages

This repo contains three Chocolatey packages.

## Packages

- `atcmd/` - Advanced Training Windows utility (v2.1.313)
- `svcadmin/` - Service Administrator (v1.00.001)
- `proxychains/` - Proxychains for Windows (v0.6.8)

## Structure

Each package has:
- `<id>.nuspec` - Package metadata
- `tools/chocolateyinstall.ps1` - Install script
- `tools/chocolateyuninstall.ps1` - Uninstall script (optional)

## Commands

```powershell
# Build .nupkg
choco pack atcmd/atcmd.nuspec
choco pack svcadmin/svcadmin.nuspec
choco pack proxychains/proxychains.nuspec

# Install local package
choco install <package> -s . --force

# Push to community feed
choco push <package>.nupkg -s https://push.chocolatey.org/
```

## Updating Versions

1. Update `<version>` in `.nuspec`
2. Update `checksum` in `tools/chocolateyinstall.ps1` (download file and run `Get-FileHash`)
3. Update URL if version changed

---

# proxychains-specific

## What it does

Routes TCP traffic through SOCKS5 proxies by hijacking Winsock functions via DLL injection.

## Requirements

- `vcredist2015` - Visual C++ Redistributable for Visual Studio 2015

## Build variants

- **Cygwin build** - if Cygwin is installed (detected via registry `HKLM:\SOFTWARE\Cygwin\setup`)
- **Win32 build** - default for Windows

## Installation specifics

- EXE files are renamed: `proxychains.exe`, `proxychains_helper.exe`
- DLL file keeps original name (e.g., `proxychains_hook_win32_x64.dll`)
- DLL folder is added to system PATH (Machine level)
- Shim files created for `proxychains.exe` and `proxychains_helper.exe`

## Uninstall specifics

- Removes DLL folder from system PATH