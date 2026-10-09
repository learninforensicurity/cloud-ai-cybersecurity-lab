# Runtime Inventory

## Purpose

This document records the runtime components that make up the Cloud AI Cybersecurity Lab.

The project separates the Windows development environment from the Google Cloud runtime.

## Current Runtime

The main runtime is the Google Cloud VM used for the laboratory.

Known runtime components:

| Component | Role | Runtime |
|---|---|---|
| Debian GNU/Linux 13 | Cloud operating system | GCP VM |
| OpenClaw Gateway | AI agent/orchestration | systemd service |
| WhatsApp | Remote user interface | OpenClaw channel |
| Open WebUI | Browser AI interface | Docker |
| Docker | Laboratory container runtime | Linux |
| OWASP WebGoat | Vulnerable web application | Docker |
| OWASP Juice Shop | Vulnerable web application | Docker |
| VSFTPD 2.3.4 lab | Intentionally vulnerable FTP target | Docker |
| Metasploit Framework | Security testing framework | Linux |

## Known OpenClaw Runtime

Gateway:

```text
ws://127.0.0.1:18789
```

Service:

```text
openclaw-gateway.service
```

The gateway is intentionally local to the runtime host.

## Known Open WebUI Runtime

Open WebUI runs in Docker and is accessed through its configured HTTP port.

The current project environment uses:

```text
http://<LAB-IP>:3000
```

Do not hard-code an environment-specific public IP into repository documentation.

## Known Docker Targets

The project uses deliberately vulnerable applications for authorized learning:

- OWASP WebGoat
- OWASP Juice Shop
- VSFTPD 2.3.4

The exact container IDs and dynamically assigned Docker IPs are runtime state and should be discovered with:

```bash
docker ps
docker inspect <container>
```

## VSFTPD Lab

The controlled VSFTPD service is mapped to localhost:

```text
127.0.0.1:2121 -> 21
127.0.0.1:6200 -> 6200
```

This localhost-only design is intentional.

## Metasploit

Verify:

```bash
which msfconsole
msfconsole --version
```

Metasploit is used only against authorized laboratory targets.

## Runtime Inventory Commands

Run:

```bash
hostname
cat /etc/os-release
docker ps
systemctl status openclaw-gateway --no-pager
ss -lntp
which msfconsole
```

## Inventory Rule

Runtime state changes.

Therefore:

- document stable architecture in Git,
- discover current container IDs/IPs at runtime,
- do not commit secrets,
- do not treat a temporary IP as permanent architecture.

## Phase 4 Goal

The objective is not merely to list software.

The objective is to show how the components connect:

```text
WhatsApp
    |
Open WebUI
    |
OpenClaw
    |
AI provider/fallbacks
    |
Authorized tools
    |
Docker / Metasploit
    |
Controlled targets
```
