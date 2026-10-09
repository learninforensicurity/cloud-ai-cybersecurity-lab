# Phase 6 — Automation, Reproducibility & Portfolio Hardening

Phase 6 turns the validated Phase 5 runtime into a repeatable, portfolio-ready workflow.

## Goals
- Validate the repository and reviewed evidence on Windows.
- Validate the known GCP runtime without changing it.
- Generate a compact Phase 6 status report and evidence bundle.
- Preserve the Phase 5 evidence boundary: no exploit-success claim is made.
- Keep the project free-first and avoid unnecessary cloud/runtime changes.

## Execution
1. Copy this package into `C:\CyberLab\cloud-ai-cybersecurity-lab` (merge/overwrite files).
2. Run the Windows batch command from the repository root:
   `powershell -ExecutionPolicy Bypass -File .\scripts\phase6-windows.ps1`
3. On GCP, run:
   `bash ~/cloud-ai-cybersecurity-lab/scripts/phase6-gcp.sh`
4. Copy the generated `evidence/phase6-*` directory back to Windows.
5. Review the report. If it is clean, commit and push the generated Phase 6 files.

The scripts are designed to be idempotent and read-only with respect to the runtime.
