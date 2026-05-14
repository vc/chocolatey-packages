# Testing Environment

VM: chocolatey/test-environment (VirtualBox)
OS: Windows Server 2019
Access: WinRM localhost:55985, RDP localhost:2200

**⚠️ Important:** `vagrant/` is a **junction** pointing to `D:\MyDocs\_Sources\chocolatey-test-environment\`.
Always verify you're editing the correct `Vagrantfile` - changes in `vagrant/Vagrantfile` affect the actual test environment.

## Before Testing

Reset VM to clean snapshot:

```bash
cd /cygdrive/d/MyDocs/_Sources/chocolatey/vagrant
vagrant snapshot restore good --no-provision
```

## Test Package

1. Copy `.nupkg` to `vagrant\packages\`:
   ```bash
   cp package.4.0.0.nupkg /cygdrive/d/MyDocs/_Sources/chocolatey/vagrant/packages/
   ```

2. Pack with full path (avoid path concatenation issues):
   ```bash
   choco pack "/cygdrive/d/MyDocs/_Sources/chocolatey/PackageName/package.nuspec"
   ```

3. Edit `vagrant/Vagrantfile` - add test line after the commented examples (around line 145):
   ```ruby
   choco.exe install -fdvy package-name --version 1.0.0 --allow-downgrade --source "'c:\\packages;http://chocolatey.org/api/v2/'"
   ```

4. Run test:
   ```bash
   cd /cygdrive/d/MyDocs/_Sources/chocolatey/vagrant
   vagrant provision
   ```

5. Exit code 0 = success

## Common Mistakes

### Path issues
- Junctions (like `vagrant/`) can cause confusion - verify working directory
- Use Cygwin paths (`/cygdrive/d/...`) in bash commands
- Quote paths with spaces in choco commands

## After Testing

Remove test line from `vagrant/Vagrantfile`

# Other vagrant functions

## Tearing Down

```bash
cd /cygdrive/d/MyDocs/_Sources/chocolatey/vagrant
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