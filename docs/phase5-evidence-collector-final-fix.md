# Phase 5 Evidence Collector — Final Correction

This version incorporates the first real runtime validation findings.

Corrections:
- OpenClaw is detected by its gateway process and listener rather than an assumed systemd unit.
- WebGoat is checked from the host because its container health check lacks `curl`.
- Juice Shop is checked from its published localhost endpoint.
- Open WebUI is checked using the endpoint actually published by Docker, rather than assuming `127.0.0.1`.
- `BASE_DIR` is exported before nested shell commands so model-routing identifiers are collected correctly.
- Listener evidence is limited to project-relevant ports.

The collector is read-only and does not restart, modify, or exploit lab containers.

## Installation

Replace:

- `scripts/collect-evidence.sh`
- `scripts/collect-evidence.ps1`

Do not commit generated evidence until it has been reviewed.

## Workflow

1. Replace the scripts on Windows.
2. Run `git diff --check`.
3. Review the staged diff.
4. Commit and push to GitHub and GitLab.
5. Pull on GCP.
6. Run `bash scripts/collect-evidence.sh`.
7. Review the new evidence.
8. Only then commit the evidence bundle.
