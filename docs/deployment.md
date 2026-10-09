# Deployment Guide

## 1. Purpose

This document explains how the Cloud AI Cybersecurity Lab is deployed and how its major components are separated between the Windows development environment and the Google Cloud runtime environment.

The project is designed as a **development-versus-runtime architecture**:

- **Windows host:** Git, GitHub/GitLab, VS Code, documentation, configuration preparation, and project administration.
- **Google Cloud VM:** Linux runtime, OpenClaw, Open WebUI, Docker, AI integrations, and controlled cybersecurity lab services.

This separation keeps development convenient while allowing the actual laboratory services to run continuously on a cloud-hosted Linux system.

---

## 2. Deployment Philosophy

The deployment follows these principles:

1. Prefer open-source software.
2. Use free API/model tiers whenever practical.
3. Use free cloud credits/free-tier resources where available.
4. Keep sensitive credentials out of Git.
5. Expose services only when necessary.
6. Keep vulnerable laboratory targets isolated and controlled.
7. Make the environment reproducible from documented configuration.
8. Record important versions and configuration changes.
9. Avoid unnecessary paid services.
10. Keep the laboratory suitable for authorized learning and experimentation.

> Free resources are not necessarily unlimited. Provider limits, model availability, pricing, quotas, and policies can change.

---

## 3. Development Environment

The Windows host is the primary development machine.

### Main tools

- Windows
- Visual Studio Code
- Git
- GitHub
- GitLab
- SSH client
- PowerShell

The project repository is located at:

```text
C:\CyberLab\cloud-ai-cybersecurity-lab
```

The repository contains documentation, architecture information, configuration examples, scripts, labs, and evidence.

---

## 4. Runtime Environment

The laboratory runtime is hosted on Google Cloud.

The current runtime environment is based on:

- Google Cloud VM
- Debian GNU/Linux 13
- Docker
- OpenClaw
- Open WebUI
- WhatsApp integration
- Metasploit Framework
- Controlled vulnerable Docker targets

The current VM used during development is:

```text
ai-kali-openclaw
```

The runtime architecture may change as the project develops. Configuration values such as IP addresses, credentials, API keys, and provider settings must not be hard-coded into public documentation.

---

## 5. Cloud VM Responsibilities

The Google Cloud VM provides the execution environment for:

### AI layer

- OpenClaw
- AI model providers
- fallback model routing
- agent tool execution

### User interface layer

- WhatsApp integration
- Open WebUI

### Cybersecurity layer

- Metasploit
- controlled vulnerable applications
- Docker-based security laboratories
- future security tooling

### Infrastructure layer

- Docker containers
- Linux services
- networking
- logs
- runtime configuration

---

## 6. OpenClaw Deployment

OpenClaw acts as the agent layer connecting users, AI models, and authorized tools.

Conceptually:

```text
User
  |
  +--> WhatsApp
  |
  +--> Open WebUI
          |
          v
      OpenClaw
          |
          +--> AI Provider
          |
          +--> Tool Execution
          |
          +--> Docker Labs
          |
          +--> Security Tools
```

The current gateway runs locally on the cloud VM:

```text
ws://127.0.0.1:18789
```

The OpenClaw gateway is managed as a Linux service.

Example service check:

```bash
systemctl status openclaw-gateway
```

A healthy deployment should show the service as active.

---

## 7. WhatsApp Deployment

WhatsApp provides a practical remote interface to the laboratory.

The intended flow is:

```text
WhatsApp
   |
   v
OpenClaw
   |
   v
AI Model
   |
   v
Authorized Tool
   |
   v
Cloud Lab
```

WhatsApp should not be treated as an unrestricted remote shell.

Commands and security testing must remain within the authorized laboratory environment.

The project also displays the backend model used for responses where configured. This makes fallback behavior visible and helps document which provider/model handled a request.

---

## 8. Open WebUI Deployment

Open WebUI provides a browser-based interface for interacting with the AI environment.

The current deployment uses Docker.

The service is accessed through the VM's appropriate network address and port.

Example:

```text
http://<LAB-IP>:3000
```

The actual IP address should be treated as an environment-specific value rather than hard-coded into public documentation.

Open WebUI provides a convenient browser interface while WhatsApp provides a mobile/remote interface.

---

## 9. Docker Deployment

Docker is used to package laboratory applications into isolated containers.

A Docker image is the packaged template.

A Docker container is a running instance of an image.

Typical workflow:

```text
Docker Image
     |
     v
Docker Container
     |
     v
Controlled Lab Service
```

Example:

```bash
docker ps
```

This command lists currently running containers.

The project currently uses Docker for applications such as:

- Open WebUI
- OWASP WebGoat
- OWASP Juice Shop
- controlled vulnerable FTP laboratory services

---

## 10. Controlled VSFTPD Laboratory

One intentionally vulnerable service used during development is VSFTPD 2.3.4.

It is deployed as a Docker container and bound to localhost-only host ports:

```text
127.0.0.1:2121 -> container port 21
127.0.0.1:6200 -> container port 6200
```

Example deployment:

```bash
docker rm -f vsftpd-lab

docker run -d \
  --name vsftpd-lab \
  -p 127.0.0.1:2121:21 \
  -p 127.0.0.1:6200:6200 \
  clintmint/vsftpd-2.3.4:1.0 \
  /bin/vsftpd /etc/vsftpd.conf
```

This laboratory service is intentionally vulnerable and must remain inside an authorized test environment.

The localhost-only bindings are an important safety boundary.

---

## 11. Vulnerable Web Applications

The laboratory also uses deliberately vulnerable applications such as:

- OWASP WebGoat
- OWASP Juice Shop

These applications are intended for learning about web application security.

They should not be exposed publicly unless the exposure is deliberate, temporary, isolated, and understood.

---

## 12. Metasploit Deployment

Metasploit Framework is installed on the cloud VM.

Example verification:

```bash
which msfconsole
msfconsole --version
```

Metasploit is used only against authorized laboratory targets.

The project does not treat the presence of an exploitation framework as permission to attack third-party systems.

---

## 13. AI Provider Deployment

The AI layer is intentionally provider-independent.

The current free-first routing strategy is:

```text
Primary
  |
  v
OpenRouter Free
  |
  +--> Gemini free model
  |
  +--> OpenCode Zen free models
```

The actual configured model order is documented in:

```text
docs/free-resources.md
```

The project deliberately uses multiple providers because availability is a major requirement.

A free model that is unavailable, rate-limited, or temporarily degraded is not useful to a continuously operating laboratory.

---

## 14. API Key Configuration

API keys must never be committed to Git.

Use environment variables or protected local configuration.

Example:

```bash
export OPENROUTER_API_KEY="..."
```

Do not place real credentials in:

- README files
- public documentation
- shell history where avoidable
- Git commits
- screenshots
- issue reports
- public evidence

The repository `.gitignore` is configured to exclude common secret and credential files.

---

## 15. Deployment Verification

After deployment, verify each major layer independently.

### Operating system

```bash
uname -a
cat /etc/os-release
```

### Docker

```bash
docker version
docker ps
```

### OpenClaw

```bash
systemctl status openclaw-gateway
```

### Open WebUI

```bash
docker ps
```

Then access the configured WebUI address.

### Security tooling

```bash
which msfconsole
msfconsole --version
```

### Network listeners

Use:

```bash
ss -lntp
```

Check that services are listening only where intended.

---

## 16. Development-to-Deployment Workflow

The normal workflow is:

```text
Windows / VS Code
       |
       v
Edit Documentation / Configuration
       |
       v
Git
       |
       +--> GitHub
       |
       +--> GitLab
       |
       v
Deploy / Update Cloud Runtime
       |
       v
Validate
       |
       v
Record Evidence
```

The cloud VM should not become the only copy of project knowledge.

Important configuration and documentation should be represented in Git, while secrets remain outside the repository.

---

## 17. Configuration Versus Secrets

A useful rule is:

### Configuration

Safe examples:

```text
service names
container names
ports
non-secret model IDs
documentation
architecture
commands
```

### Secrets

Examples:

```text
API keys
access tokens
passwords
private keys
session credentials
service-account credentials
```

Configuration may be documented.

Secrets must be protected.

---

## 18. Reproducibility

A deployment is considered more reproducible when another learner can understand:

1. what software is required,
2. what versions were tested,
3. what services are required,
4. how the services communicate,
5. what configuration is needed,
6. where secrets must be supplied,
7. how to verify the installation,
8. what limitations exist.

This project therefore treats documentation as part of the technical implementation rather than as an optional extra.

---

## 19. Cloud Cost Awareness

The project is designed around a free-first model.

However, Google Cloud promotional credits are not the same thing as permanently free infrastructure.

Before creating or resizing resources, check:

- VM size
- disk size
- network usage
- running time
- external IP requirements
- service-specific pricing
- remaining promotional credit

Avoid leaving unnecessary cloud resources running.

---

## 20. Deployment Checklist

Before considering a deployment complete:

- [ ] Cloud VM is reachable
- [ ] Linux environment is healthy
- [ ] Docker is operational
- [ ] OpenClaw gateway is running
- [ ] AI providers are configured
- [ ] Fallback models are configured
- [ ] WhatsApp integration works
- [ ] Open WebUI works
- [ ] Metasploit is available
- [ ] Vulnerable targets are isolated
- [ ] Sensitive credentials are not committed
- [ ] Network listeners have been reviewed
- [ ] Documentation reflects the tested deployment
- [ ] Evidence has been recorded

---

## 21. Important Limitation

This document describes the deployment architecture and the environment tested during project development.

Cloud provider interfaces, OpenClaw behavior, Docker images, AI providers, model IDs, free tiers, pricing, and network configurations can change.

Always verify the current environment before applying an old command to a new deployment.
