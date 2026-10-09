# Runtime Configuration

## 1. Purpose

Phase 3 converts the Phase 2 architecture into a practical configuration plan.

The project deliberately separates:

- **documentation**
- **non-secret configuration**
- **secrets**
- **runtime services**
- **laboratory targets**

This prevents the public Git repositories from becoming a storage location for credentials.

---

## 2. Runtime Components

The current laboratory runtime is based on:

```text
Google Cloud VM
└── Debian GNU/Linux 13
    ├── OpenClaw Gateway
    ├── Open WebUI
    ├── Docker
    │   ├── WebGoat
    │   ├── Juice Shop
    │   └── VSFTPD laboratory
    ├── Metasploit Framework
    └── AI provider integrations
```

The Windows host remains the primary development/documentation environment.

---

## 3. Configuration Layers

Configuration is divided into four layers.

### Layer 1 — Repository configuration

Safe to version-control:

- documentation
- model IDs
- port definitions
- service names
- example configuration
- scripts that do not contain secrets

### Layer 2 — Local environment configuration

May contain environment-specific values:

- VM address
- local paths
- runtime preferences
- non-secret service settings

### Layer 3 — Secrets

Never commit:

- API keys
- access tokens
- passwords
- private keys
- cloud credentials
- session credentials

### Layer 4 — Runtime state

Examples:

- OpenClaw state
- Open WebUI data
- Docker volumes
- logs
- temporary files

Runtime state should not automatically become part of the Git repository.

---

## 4. Environment Variables

Use environment variables for secrets and environment-specific values.

A safe pattern is:

```text
.env.example
      |
      v
copy to local .env
      |
      v
insert local secrets
      |
      v
runtime
```

The real `.env` file remains ignored by Git.

---

## 5. Required AI Configuration

The AI layer currently uses a free-first routing strategy.

Primary:

```text
openrouter/free
```

Fallbacks:

```text
google/gemini-3.5-flash-lite
opencode/big-pickle
opencode/longcat-2.5-preview-free
opencode/mimo-v2.6-flash-free
opencode/nemotron-3.5-lightning-free
opencode/space-bunny-free
```

These model IDs represent the configuration tested during project development.

Provider/model availability can change. Treat `docs/free-resources.md` as the project record of the tested strategy rather than a guarantee of permanent availability.

---

## 6. Availability-First Design

The project prioritizes availability over loyalty to one provider.

The intended logic is:

```text
Request
   |
   v
Primary model
   |
   +---- available ----> response
   |
   +---- unavailable
             |
             v
        Fallback 1
             |
             +---- available ----> response
             |
             v
        Fallback 2
             |
             v
            ...
```

A temporary HTTP 429 should not necessarily stop the entire AI layer.

---

## 7. OpenRouter Configuration

OpenRouter is used as a model-routing/provider layer.

The project currently prefers the free routing option:

```text
openrouter/free
```

API credentials must be supplied through protected runtime configuration.

Never put a real OpenRouter key into:

```text
README.md
docs/
configs/
Git commits
screenshots
```

---

## 8. Gemini Configuration

Google Gemini is included as a fallback provider.

The tested model is:

```text
google/gemini-3.5-flash-lite
```

The exact provider configuration syntax depends on the OpenClaw/provider configuration currently installed on the runtime VM.

Do not blindly copy configuration syntax from an older OpenClaw release.

First inspect the installed version and supported configuration schema.

---

## 9. OpenCode Zen Configuration

OpenCode Zen provides additional free model options used by the project.

The tested models are:

```text
opencode/big-pickle
opencode/longcat-2.5-preview-free
opencode/mimo-v2.6-flash-free
opencode/nemotron-3.5-lightning-free
opencode/space-bunny-free
```

The project uses these as availability-oriented fallbacks rather than assuming that any one free model will always be available.

---

## 10. OpenClaw Configuration

The current runtime uses an OpenClaw gateway service:

```text
openclaw-gateway.service
```

The local gateway endpoint is:

```text
ws://127.0.0.1:18789
```

Current agent capabilities include authorized command execution on the laboratory gateway.

Because OpenClaw configuration syntax can change between releases, the project stores configuration principles and environment variables in Git while keeping live runtime state outside Git.

---

## 11. Native Execution

The current laboratory configuration enables native execution on the gateway.

The tested execution policy included:

```text
tools.exec.host = gateway
tools.exec.mode = full
tools.exec.strictInlineEval = false
tools.codeMode = false
```

Approval behavior was also configured for the laboratory runtime.

These settings are powerful and should not be copied into an Internet-facing production environment without a security review.

---

## 12. WhatsApp Configuration

WhatsApp is the remote user interface.

The current runtime uses a response prefix that identifies the backend model:

```text
[Model: {modelFull}]
```

This is useful when testing fallback behavior because the user can see which backend handled a request.

WhatsApp should remain an authorized interface to the laboratory rather than an unrestricted public command channel.

---

## 13. Open WebUI Configuration

Open WebUI runs as a Docker service.

Current intended access pattern:

```text
Browser
   |
   v
Open WebUI :3000
   |
   v
AI runtime
```

Do not hard-code the current cloud IP into source documentation.

Use:

```text
<LAB-IP>:3000
```

in public documentation and environment-specific values locally.

---

## 14. Docker Configuration

The project uses Docker to isolate laboratory applications.

Expected services include:

```text
open-webui
webgoat
juice-shop
vsftpd-lab
```

The exact container inventory may change.

Inspect the live runtime with:

```bash
docker ps
```

---

## 15. Controlled VSFTPD Configuration

The deliberately vulnerable VSFTPD service uses localhost-only host mappings:

```text
127.0.0.1:2121 -> 21
127.0.0.1:6200 -> 6200
```

This is intentional.

The target is not supposed to become a public Internet service.

---

## 16. Configuration Validation

After configuration changes:

```bash
systemctl status openclaw-gateway
docker ps
ss -lntp
```

Then test:

1. Open WebUI.
2. WhatsApp.
3. harmless OpenClaw command execution.
4. model identification.
5. primary model.
6. fallback model.
7. controlled lab connectivity.

---

## 17. Configuration Change Procedure

Use this sequence:

```text
Change
  |
  v
Validate syntax/configuration
  |
  v
Restart only affected service
  |
  v
Check service status
  |
  v
Run functional test
  |
  v
Check network exposure
  |
  v
Record result
  |
  v
Commit safe configuration/documentation
```

Avoid making many unrelated configuration changes simultaneously.

---

## 18. Configuration Backup

Back up configuration in two categories.

### Version-controlled

```text
docs/
configs/*.example
scripts/
architecture/
```

### Protected runtime backup

```text
real .env
OpenClaw state
provider credentials
session data
private keys
```

Protected runtime backups must not be pushed to public Git repositories.

---

## 19. Configuration Checklist

- [ ] AI primary configured
- [ ] AI fallbacks configured
- [ ] API keys stored outside Git
- [ ] OpenClaw gateway active
- [ ] Native execution reviewed
- [ ] WhatsApp connected
- [ ] model identification enabled
- [ ] Open WebUI running
- [ ] Docker running
- [ ] vulnerable targets isolated
- [ ] listeners reviewed
- [ ] configuration documented
- [ ] no secrets staged in Git

---

## 20. Important Versioning Rule

OpenClaw and AI providers evolve quickly.

Before changing live configuration:

```bash
openclaw --version
```

Then verify the configuration syntax supported by that installed release.

This repository documents the tested architecture and intent; it should not encourage blindly applying obsolete configuration syntax.
