$ErrorActionPreference = 'Stop'
$Root = (Get-Location).Path
if (-not (Test-Path (Join-Path $Root 'README.md')) -or -not (Test-Path (Join-Path $Root '.git'))) {
  throw 'Run this script from the cloud-ai-cybersecurity-lab repository root.'
}
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$out = Join-Path $Root "evidence/phase6-windows-$stamp"
New-Item -ItemType Directory -Force $out | Out-Null
@(
  'Cloud AI Cybersecurity Lab - Phase 6 Windows Validation'
  "Timestamp: $stamp"
  "Root: $Root"
) | Set-Content -Encoding UTF8 (Join-Path $out '00-summary.txt')
@('--- git status ---') | Set-Content -Encoding UTF8 (Join-Path $out '01-git.txt')
git status --short --branch | Add-Content (Join-Path $out '01-git.txt')
@('--- remotes ---') | Add-Content (Join-Path $out '01-git.txt')
git remote -v | Add-Content (Join-Path $out '01-git.txt')
@('--- latest commits ---') | Add-Content (Join-Path $out '01-git.txt')
git log -5 --oneline | Add-Content (Join-Path $out '01-git.txt')
@('--- required files ---') | Set-Content -Encoding UTF8 (Join-Path $out '02-repository.txt')
$required = @(
  'README.md','.gitignore','docs/architecture.md','docs/concepts.md','docs/deployment.md',
  'docs/free-resources.md','docs/security.md','docs/testing.md','docs/phase6.md',
  'docs/phase6-checklist.md','scripts/health-check.ps1',
  'evidence/reviewed-runtime-20261009-182500/08-review-status.txt'
)
foreach ($p in $required) {
  if (Test-Path (Join-Path $Root $p)) { "PASS $p" | Add-Content (Join-Path $out '02-repository.txt') }
  else { "FAIL $p" | Add-Content (Join-Path $out '02-repository.txt') }
}
@('--- privacy scan of reviewed evidence ---') | Set-Content -Encoding UTF8 (Join-Path $out '03-privacy.txt')
$review = Join-Path $Root 'evidence/reviewed-runtime-20261009-182500'
if (Test-Path $review) {
  $text = (Get-ChildItem $review -File | Get-Content -Raw) -join "`n"
  $patterns = @('10\.\d+\.\d+\.\d+','172\.\d+\.\d+\.\d+','192\.168\.\d+\.\d+','100\.69\.45\.127','/home/[A-Za-z0-9_-]+')
  $bad = $false
  foreach ($pat in $patterns) {
    if ($text -match $pat) { "FAIL pattern $pat" | Add-Content (Join-Path $out '03-privacy.txt'); $bad = $true }
    else { "PASS pattern $pat" | Add-Content (Join-Path $out '03-privacy.txt') }
  }
  if (-not $bad) { 'PASS privacy scan' | Add-Content (Join-Path $out '03-privacy.txt') }
} else {
  'FAIL reviewed evidence directory missing' | Add-Content (Join-Path $out '03-privacy.txt')
}
'Phase 6 Windows validation complete. Runtime was not modified.' | Add-Content (Join-Path $out '00-summary.txt')
Write-Host "PHASE6_WINDOWS_OUTPUT=$out"
