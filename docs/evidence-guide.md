# Evidence Guide

## Goal

Create portfolio-quality evidence without exposing secrets or unnecessary infrastructure details.

## Good evidence

- command output showing a service is active
- Docker container status
- application version
- local listener information
- controlled-lab connectivity
- model-routing configuration with API keys removed
- timestamps proving when validation occurred

## Sensitive evidence to remove

Before committing evidence, inspect it for:

- API keys
- access tokens
- passwords
- cookies
- SSH private keys
- cloud service-account credentials
- WhatsApp authentication/session data
- private hostnames or addresses when disclosure is unnecessary

## Recommended evidence naming

```text
evidence/
└── runtime-YYYYMMDD-HHMMSS/
    ├── 00-summary.txt
    ├── 01-host.txt
    ├── 02-openclaw.txt
    ├── 03-docker.txt
    ├── 04-labs.txt
    ├── 05-metasploit.txt
    ├── 06-model-routing.txt
    └── 07-listeners.txt
```

## Review rule

Never commit an evidence directory merely because a collection script completed. Open the files first and inspect the contents.

A successful collection means that evidence was collected, not that every component passed.

## Portfolio presentation

A good final project should distinguish:

- **PASS** — directly verified during the validation run
- **INFO** — observed/configuration information
- **NOT TESTED** — no evidence captured
- **FAIL** — validation produced an error
- **NOT APPLICABLE** — deliberately outside the current phase
