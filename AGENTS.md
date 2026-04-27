# Chocolatey Packages

This repo contains Chocolatey packages.

## Structure

Each package has:
- `<id>.nuspec` - Package metadata
- `tools/chocolateyinstall.ps1` - Install script
- `tools/chocolateyuninstall.ps1` - Uninstall script (optional)

## Nuspec structure

A `.nuspec` file is an XML manifest containing package metadata. It is required for building the package and provides information to consumers.

### Basic structure

```xml
<?xml version="1.0" encoding="utf-8"?>
<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
    <metadata>
        <!-- Required elements -->
        <id></id>
        <version></version>
        <description></description>
        <authors></authors>

        <!-- Optional elements -->
    </metadata>
    <!-- Optional files node -->
</package>
```

### Required metadata elements

| Element | Description | Limits |
|---------|-------------|--------|
| `id` | Case-insensitive package identifier. Must be unique across the gallery. No spaces or URL-invalid characters. | 128 chars |
| `version` | Package version following major.minor.patch pattern. Can include pre-release suffix. | 64 chars |
| `description` | Description of the package for UI display. | 4000 chars |
| `authors` | Comma-separated list of package authors. | |

### Optional metadata elements

The following elements are optional but recommended for better package discoverability and user experience:

| Element | Description |
|---------|-------------|
| `title` | Human-friendly title for UI display. |
| `owners` | Comma-separated list of package owners. (Deprecated - use authors) |
| `projectUrl` | URL to the package's home page. |
| `licenseUrl` | URL to the package's license. (Deprecated - use license) |
| `requireLicenseAcceptance` | Boolean - prompt consumer to accept license before install. |
| `packageSourceUrl` | URL to the package source code. |
| `docsUrl` | URL to the documentation. |
| `mailingListUrl` | URL to the mailing list. |
| `bugTrackerUrl` | URL to the bug tracker. |
| `projectSourceUrl` | URL to the project source code (for runtime). |
| `license` | SPDX license expression or path to license file within package. |
| `iconUrl` | URL for 128x128 icon image. (Deprecated - use icon) |
| `icon` | Path to icon file within package (PNG/JPEG, max 1MB, 128x128 recommended). |
| `readme` | Path to readme file (Markdown only). |
| `developmentDependency` | Boolean - mark as development-only dependency. |
| `summary` | Short description (deprecated - use description). |
| `releaseNotes` | Description of changes in this release. |
| `copyright` | Copyright details. |
| `language` | Locale ID for localized packages. |
| `tags` | Space-delimited list of tags for search/discoverability. |
| `repository` | Repository metadata (type, url, branch, commit). |
| `minClientVersion` | Minimum NuGet client version required to install. |

### Dependencies

```xml
<dependencies>
    <dependency id="PackageName" version="1.0.0" />
    <dependency id="PackageB" version="[1,2)" />  <!-- version range -->
</dependencies>
```

Version can be exact, range, or floating. Ranges use notation like `[1.0.0,2.0.0)` (inclusive, exclusive).

### Dependencies with framework targeting

```xml
<dependencies>
    <group>
        <dependency id="PackageA" version="1.0.0" />
    </group>
    <group targetFramework=".NETFramework4.7.2">
        <dependency id="PackageB" version="1.0.0" />
    </group>
</dependencies>
```

### Files element

Specifying files to include in the package:

```xml
<files>
    <file src="bin\*.dll" target="lib" />
    <file src="tools\**\*.*" target="tools" exclude="**\*.log" />
</files>
```

**File element attributes:**

| Attribute | Description |
|-----------|-------------|
| `src` | Location of files (relative to nuspec, wildcards supported). |
| `target` | Relative path in package (must start with lib, content, build, or tools). |
| `exclude` | Files/patterns to exclude (semicolon-delimited). |

### Package folder structure conventions

| Folder | Purpose |
|--------|----------|
| `lib` | Assemblies for referencing. |
| `tools` | Executable scripts and utilities. |
| `content` | Content files for project. |
| `build` | MSBuild props and targets. |

### Example nuspec

```xml
<?xml version="1.0" encoding="utf-8"?>
<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
    <metadata>
        <id>my-package</id>
        <version>1.0.0</version>
        <title>My Package</title>
        <authors>Author Name</authors>
        <owners>Author Name</owners>
        <description>A short description of the package.</description>
        <projectUrl>https://github.com/username/repo</projectUrl>
        <license type="expression">MIT</license>
        <tags>admin tag1 tag2</tags>
        <dependencies>
            <dependency id="chocolatey" version="0.9.9" />
        </dependencies>
    </metadata>
    <files>
        <file src="tools\**" target="tools" />
    </files>
</package>
```

### Notes

- All XML element names are case-sensitive.
- Use UTF-8 encoding with BOM for nuspec files with non-ASCII characters.
- Chocolatey adds optional functionality on top of NuGet's Nuspec format.
- For features introduced in specific Chocolatey versions, add chocolatey as a dependency.


## Commands

```powershell
# Build .nupkg
choco pack <package folder>/<package>.nuspec

# Install local package
wordir ./
choco install <package> -s . --force

# Locally test package

Read `TEST.md`

# Push to community feed
choco push <package>.nupkg -s https://push.chocolatey.org/
```

## Updating Versions

1. Update `<version>` in `.nuspec`
2. Update `checksum` in `tools/chocolateyinstall.ps1` (download file and run `Get-FileHash`)
3. Update URL if version changed

# Packages

Packages info view in README.md
