#Requires -Version 5.0
class SourceForge {
    [string]        $Project = $Null
    [PSCustomObject]$LatestRelease = $Null

    
    SourceForge([string] $project) {
        $this.Project = $project
        $this.GetLatestRelease()
    }

    
    [void] GetLatestRelease() {
        $originalSecurityProtocol = [Net.ServicePointManager]::SecurityProtocol
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        
        $this.GetLatestRelease('https://sourceforge.net/projects/{0}/best_release.json')
        
        [Net.ServicePointManager]::SecurityProtocol = $originalSecurityProtocol
    }


    [void] GetLatestRelease([string] $url) {
        $url = $url -f @($this.Project)
        Write-Debug "[SourceForge].GetLatestRelease URL: ${url}"
        $this.LatestRelease = ConvertFrom-Json (Invoke-WebRequest $url -UseBasicParsing).Content
    }

    
    [string] LatestVersion() {
        if (-not $this.LatestRelease) {
            $this.GetLatestRelease()
        }

        return $this.LatestRelease.release.filename.Split('/')[2]
    }

    [hashtable] LatestHash() {
        if (-not $this.LatestRelease) {
            $this.GetLatestRelease()
        }

        return @{
            'Algorithm' = 'MD5';
            'Hash' = $this.LatestRelease.release.md5sum.ToUpper();
        }
    }
}
