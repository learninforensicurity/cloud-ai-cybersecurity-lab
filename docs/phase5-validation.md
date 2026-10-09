# Phase 5 — Validation, Evidence, and Reproducibility

## Purpose

Phase 5 turns the documented Cloud AI Cybersecurity Lab into a reproducible portfolio project by capturing safe evidence from the real runtime.

This phase does **not** fabricate successful results. It provides read-only collection tooling and evidence templates. The actual GCP runtime must produce the evidence.

## Validation scope

Validate these layers:

1. GCP runtime health
2. OpenClaw gateway
3. WhatsApp integration
4. Open WebUI
5. Docker and controlled security labs
6. Metasploit availability
7. AI model routing/fallback configuration
8. Basic end-to-end connectivity

## Safety boundary

Evidence collection is read-only. It must not:

- exploit public systems
- scan arbitrary Internet targets
- reveal API keys, tokens, cookies, passwords, or private keys
- modify production systems
- claim an exploit succeeded when it did not

Only use the controlled lab targets documented by this project.

## Reproducibility workflow

Run the GCP collection script:

```bash
cd ~/cloud-ai-cybersecurity-lab
bash scripts/collect-evidence.sh
```

The script creates a timestamped evidence directory under:

```text
evidence/runtime-YYYYMMDD-HHMMSS/
```

Review the files before committing anything.

## Evidence categories

| Category | Evidence |
|---|---|
| Host | OS, kernel, CPU, RAM, disk |
| OpenClaw | version and service state |
| Interfaces | gateway/listener checks |
| Docker | version, containers, networks |
| Labs | WebGoat, Juice Shop, VSFTPD status |
| Metasploit | version/path only |
| AI routing | configured model names, with secrets excluded |
| Reproducibility | commands and timestamps |

## Important

Dynamic values such as container IDs, container IPs, timestamps, and runtime IP addresses may change. They are evidence of a particular run, not permanent architecture values.

Do not commit raw `.env` files or credential-bearing output.
