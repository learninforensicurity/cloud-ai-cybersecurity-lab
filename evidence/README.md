# Runtime Evidence

This directory stores reviewed, redacted validation evidence for the Cloud AI Cybersecurity Lab.

## Rules

- Do not place secrets here.
- Do not place raw `.env` files here.
- Do not place WhatsApp session/authentication data here.
- Review generated evidence before committing it.
- Dynamic IPs, container IDs, and timestamps may change between runs.
- Evidence must represent an actual runtime observation.

## Expected structure

```text
runtime-YYYYMMDD-HHMMSS/
├── 00-summary.txt
├── 01-host.txt
├── 02-openclaw.txt
├── 03-docker.txt
├── 04-labs.txt
├── 05-metasploit.txt
├── 06-model-routing.txt
└── 07-listeners.txt
```

The repository intentionally does not include fabricated runtime results.
