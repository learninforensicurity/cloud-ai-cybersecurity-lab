# Cloud AI Cybersecurity Lab - Windows development health check
# This script checks the Git/development side only.

Write-Host "=== Cloud AI Cybersecurity Lab Development Check ==="
Write-Host ""

Write-Host "[1] Git"
git --version

Write-Host ""
Write-Host "[2] Repository"
git status --short
git branch --show-current

Write-Host ""
Write-Host "[3] Remotes"
git remote -v

Write-Host ""
Write-Host "[4] Git integrity"
git diff --check

Write-Host ""
Write-Host "[5] Recent commits"
git log --oneline -5

Write-Host ""
Write-Host "Development check complete."
