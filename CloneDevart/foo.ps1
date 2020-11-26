function Scan {
    param([string] $AgentVersion, [switch] $Packages, [switch] $Bin, [switch] $Obj)
    Push-Location $PSScriptRoot
    try {
        dotnet build | Out-Null
        if (-not $Packages) { Remove-Item packages -Recurse }
        if (-not $Bin) { Remove-Item bin -Recurse }
        if (-not $Obj) { Remove-Item obj -Recurse }
        $url = "https://github.com/whitesource/unified-agent-distribution/releases/download/v$AgentVersion/wss-unified-agent.jar"
        $jar = "..\$AgentVersion\wss-unified-agent.jar"
        if (-Not (Test-Path $jar)) { Invoke-RestMethod $url -OutFile $jar }
        java -jar "..\$AgentVersion\wss-unified-agent.jar" | Out-Null
        if ($LastExitCode -ne 0) { throw "$AgentVersion\wss-unified-agent.jar exited with code $LastExitCode" }
        $result = Get-Content whitesource\update-request.txt | ConvertFrom-Json
        Write-Host "Scanned using agent v$AgentVersion, $($result.projects[0].dependencies.count) dependencies found" -Fore Blue
    }
    finally { Pop-Location }
}

"With just the packages folder:"
Scan "20.8.1" -Packages
Scan "20.11.1" -Packages
"With just the obj folder:"
Scan "20.8.1" -Obj
Scan "20.11.1" -Obj
"With just the bin folder:"
Scan "20.8.1" -Bin
Scan "20.11.1" -Bin
