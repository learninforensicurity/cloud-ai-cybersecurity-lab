$ErrorActionPreference = 'Stop'
$Root = (Get-Location).Path
$Stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$Out = Join-Path $Root "evidence\phase7-windows-$Stamp"
New-Item -ItemType Directory -Force -Path $Out | Out-Null

"Cloud AI Cybersecurity Lab - Phase 7 Windows Portfolio Validation" | Set-Content (Join-Path $Out '00-summary.txt')
"Timestamp local: $Stamp" | Add-Content (Join-Path $Out '00-summary.txt')

"=== GIT ===" | Add-Content (Join-Path $Out '00-summary.txt')
git status --short --branch | Add-Content (Join-Path $Out '00-summary.txt')
git log -1 --oneline | Add-Content (Join-Path $Out '00-summary.txt')
git remote -v | Add-Content (Join-Path $Out '00-summary.txt')

"=== REQUIRED FILES ===" | Set-Content (Join-Path $Out '01-files.txt')
$required = @('README.md','.gitignore','docs\architecture.md','docs\concepts.md','docs\deployment.md','docs\free-resources.md','docs\security.md','docs\testing.md','docs\phase6.md','scripts\phase6-windows.ps1','scripts\phase6-gcp.sh')
foreach ($f in $required) { "{0} {1}" -f ($(if(Test-Path (Join-Path $Root $f)){'PASS'}else{'MISSING'}),$f) | Add-Content (Join-Path $Out '01-files.txt') }

"=== SECRET-PATTERN SCAN ===" | Set-Content (Join-Path $Out '02-secret-scan.txt')
$patterns = 'BEGIN (RSA|EC|OPENSSH|PRIVATE) KEY','AKIA[0-9A-Z]{16}','ghp_[A-Za-z0-9]{20,}','glpat-[A-Za-z0-9_-]{20,}','sk-[A-Za-z0-9_-]{20,}','xox[baprs]-[A-Za-z0-9-]{10,}'
$hits = @()
Get-ChildItem -Recurse -File -Force -ErrorAction SilentlyContinue | Where-Object { $_.FullName -notmatch '\\.git\\' -and $_.Length -lt 2MB } | ForEach-Object {
  try { $txt = Get-Content $_.FullName -Raw -ErrorAction Stop; foreach($p in $patterns){ if($txt -match $p){ $hits += $_.FullName.Replace($Root+'\','') } } } catch {}
}
$hits | Sort-Object -Unique | Add-Content (Join-Path $Out '02-secret-scan.txt')
if(-not $hits){ 'NO_OBVIOUS_SECRET_PATTERNS_FOUND' | Add-Content (Join-Path $Out '02-secret-scan.txt') }

"=== ARTIFACTS ===" | Set-Content (Join-Path $Out '03-artifacts.txt')
Get-ChildItem -Recurse -File -Force -ErrorAction SilentlyContinue | Where-Object { $_.Name -match '\.(zip|7z|rar)$' -or $_.Name -match '^\.env$' } | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Replace($Root+'\','') } | Add-Content (Join-Path $Out '03-artifacts.txt')

"=== RESULT ===" | Set-Content (Join-Path $Out '04-status.txt')
'Repository structure checked.' | Add-Content (Join-Path $Out '04-status.txt')
'No exploit execution performed.' | Add-Content (Join-Path $Out '04-status.txt')
'Artifact findings require human review; they are not automatically failures.' | Add-Content (Join-Path $Out '04-status.txt')
"PHASE7_WINDOWS_OUTPUT=$Out"
