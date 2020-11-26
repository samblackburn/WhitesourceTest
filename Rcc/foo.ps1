function Scan {
    param([string] $AgentVersion)
    Push-Location $PSScriptRoot
    try {
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

Scan "20.8.1"
Scan "20.11.1"
