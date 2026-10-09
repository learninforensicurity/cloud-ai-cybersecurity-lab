$ErrorActionPreference = "Continue"

$BaseDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$Stamp = (Get-Date).ToUniversalTime().ToString("yyyyMMdd-HHmmss")
$Out = Join-Path $BaseDir "evidence\runtime-$Stamp"
New-Item -ItemType Directory -Force -Path $Out | Out-Null

function Run-Command($File, $Command) {
    $Path = Join-Path $Out $File
    @"
=== Command ===
$Command
=== UTC ===
$((Get-Date).ToUniversalTime().ToString("o"))
=== Output ===
"@ | Set-Content $Path
    cmd /c $Command 2>&1 | Out-File $Path -Append -Encoding utf8
}

Run-Command "01-host.txt" "hostname & ver & wmic cpu get NumberOfCores,NumberOfLogicalProcessors 2>nul & wmic computersystem get TotalPhysicalMemory 2>nul"
Run-Command "02-docker.txt" "docker version 2>&1 & docker ps --format `"table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}`""
Run-Command "03-network.txt" "netstat -ano | findstr LISTENING"
Run-Command "04-git.txt" "git -C `"$BaseDir`" status --short --branch & git -C `"$BaseDir`" log -1 --oneline"

@"
Cloud AI Cybersecurity Lab — Windows Evidence Collection

UTC timestamp: $((Get-Date).ToUniversalTime().ToString("o"))
Evidence directory: $Out

Review every file before committing it.
"@ | Set-Content (Join-Path $Out "00-summary.txt")

Write-Host "Evidence collection complete: $Out"
Write-Host "Review the files before committing."
