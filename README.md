This is a SourceForge helper class.

# Examples

Just import the [sourceforge.ps1](/posh/SourceForge-API/blob/master/sourceforge.ps1) file:

```powershell
. '.\sourceforge.ps1'
```

Then, profit ...

## WinSCP

```powershell
$winscp = [SourceForge]::new('winscp')
$winscp.LatestVersion()
$winscp.LatestHash()
```

## Filezilla

```powershell
$filezilla = [SourceForge]::new('filezilla')
$filezilla.LatestVersion()
$filezilla.LatestHash()
```