# Testing Environment

VM: chocolatey/test-environment (VirtualBox)
OS: Windows Server 2019
Access: WinRM localhost:55985, RDP localhost:2200

## Before Testing

Reset VM to clean snapshot:

```powershell
vagrant snapshot restore good --no-provision
```

## Test Package

1. Copy `.nupkg` to `vagrant\packages\`
2. Edit `Vagrantfile` - add test line:
   ```ruby
   choco.exe install -fdvy package-name --version 1.0.0 --source "'c:\\packages;http://chocolatey.org/api/v2/'"
   ```
3. Run test:
   ```powershell
   vagrant provision
   ```
4. Exit code 0 = success

## After Testing

1. Remove test line from `Vagrantfile`

# Other vaagrant functions

## Tearing Down

```powershell
vagrant destroy      # Delete VM
vagrant up        # Recreate
vagrant snapshot save good  # New snapshot
```

## Exit Codes

Valid exit codes:
- `0` - Success
- `1605` - Already installed
- `1614` - Already uninstalled
- `1641` - Pending reboot
- `3010` - Success, requires reboot

## Useful Commands

| Command | Description |
|---------|-------------|
| `vagrant status` | Check VM status |
| `vagrant halt` | Stop the VM |
| `vagrant reload` | Restart the VM |
| `vagrant snapshot list` | List snapshots |
| `vagrant snap delete good` | Delete snapshot |
| `vagrant ssh` | SSH into VM (if using Linux) |
| `vagrant winrm` | WinRM into VM (Windows) |