# Cloud AI Cybersecurity Lab - Windows repository inventory

Write-Host "=== Cloud AI Cybersecurity Lab Repository Inventory ==="
Write-Host ""

Write-Host "[Repository]"
Get-Location
git branch --show-current

Write-Host ""
Write-Host "[Git Status]"
git status --short

Write-Host ""
Write-Host "[Remotes]"
git remote -v

Write-Host ""
Write-Host "[Recent Commits]"
git log --oneline -5

Write-Host ""
Write-Host "[Project Files]"
Get-ChildItem -Recurse -File |
    Where-Object {
        $_.FullName -notmatch '\\.git\\' -and
        $_.FullName -notmatch '\\node_modules\\'
    } |
    Select-Object FullName, Length

Write-Host ""
Write-Host "Repository inventory complete."
