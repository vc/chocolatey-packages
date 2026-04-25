# Chocolatey Packages Repository

This repository contains Chocolatey packages for Windows.

## Available Packages

| Package | Description | Version |
|---------|-------------|---------|
| `atcmd/` | Advanced Training Windows utility | 2.1.313 |
| `svcadmin/` | Service Administrator | 1.00.001 |
| `proxychains/` | Proxychains for Windows | 0.6.8 |
| `apt-cyg/` | apt-get like tool for Cygwin | 2025.9.3 |
| `gossip/` | Nostr client | 0.14.0 |
| `ipban/` | Fail2Ban for Windows | 4.0.0-prerelease |

## Quick Start

```powershell
# Build .nupkg
choco pack <package>/<package>.nuspec

# Install local package
choco install <package> -s . --force

# Push to community feed
choco push <package>.nupkg -s https://push.chocolatey.org/
```

## Package Structure

Each package has:
- `<id>.nuspec` - Package metadata
- `tools/chocolateyinstall.ps1` - Install script
- `tools/chocolateyuninstall.ps1` - Uninstall script (optional)

---

## Package Details

### ipban - Fail2Ban for Windows

**Source**: [DigitalRuby/IPBan](https://github.com/DigitalRuby/IPBan)

**Description**: Free, open-source security software that blocks hackers and botnets by automatically banning IP addresses that fail to authenticate multiple times.

**Version**: 4.0.0-prerelease (.NET 10 required)

**Supported services**: RDP, OpenSSH, VNC, MySQL, SQL Server, Exchange, and more.

**Requirements**:
- Windows 10/Server 2016 or newer
- .NET 10 runtime

**Install**:
```powershell
choco install ipban --pre
```

**Usage notes**:
- Installs as Windows Service (`IPBAN`)
- Default startup type: `delayed-auto`
- Configuration: `C:\Program Files\IPBan\ipban.config`
- Remember to whitelist your trusted IP addresses after installation

---

### proxychains

Routes TCP traffic through SOCKS5 proxies via DLL injection.

**Requirements**: `vcredist2015`

**Installation specifics**:
- EXE files renamed: `proxychains.exe`, `proxychains_helper.exe`
- DLL folder added to system PATH

---

### apt-cyg

apt-get like tool for Cygwin (fork by kou1okada).

**Source**: https://github.com/kou1okada/apt-cyg

**Version**: 2025.9.3

**Requirements**: Cygwin, `coreutils`, `wget`, `ca-certificates`, `gnupg`, `libiconv`

**Installation specifics**:
- Automatically installs missing Cygwin packages via `cygwinsetup.exe`
- Installs apt-cyg script to `/bin/apt-cyg`
- Requires `coreutils` for the `install` command

---

### gossip

Desktop client for the Nostr protocol.

**Source**: https://github.com/mikedilger/gossip

**Version**: 0.14.0 (semver)

**Install**: MSI from GitHub releases (self-contained)

---

### atcmd

Advanced Training Windows utility.

**Source**: https://www.atraining.ru/soft/

**Version**: 2.1.313

**Requirements**:
- Windows with TLS 1.3 support (Server 2022+, Windows 11, or Windows 10 with updates)
- `curl` package (used for TLS 1.3 download)
- `kb2999226` (Universal C Runtime)
- `vcredist2017` (Visual C++ 2017)

**Installation specifics**:
- Downloads ZIP from `cdn.atraining.ru`
- Uses `curl` for download due to TLS 1.3 requirement (Windows SChannel TLS fails on older systems)

**Known issue**: The download server (`cdn.atraining.ru`) requires TLS 1.3. Windows SChannel (used by PowerShell/Invoke-WebRequest) has limited TLS 1.3 support on Windows 10. The package uses `curl` (which uses LibreSSL/OpenSSL) as a workaround.

**If installation fails with SSL/TLS error**:
1. Ensure `curl` is installed: `choco install curl`
2. Or update Windows to enable TLS 1.3 support

---

### svcadmin

Service Administrator.