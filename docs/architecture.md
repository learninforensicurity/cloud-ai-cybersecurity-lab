# Architecture

## Cloud AI Cybersecurity Lab Architecture

The project combines Cloud Computing, Artificial Intelligence, and Cybersecurity into one practical laboratory. The architecture will evolve as the project grows.

## 1. High-Level Architecture

```text
User
 ├── WhatsApp
 └── Open WebUI
        |
        v
   OpenClaw AI Agent
        |
   +----+----------------+
   |    |                |
   v    v                v
OpenRouter  Gemini   OpenCode Zen
 Free       Free       Free models
        |
        v
  Tool / Exec Layer
        |
   +----+------------------+
   |                       |
   v                       v
Linux / Docker        Security Tools
   |                   - Metasploit
   |                   - Nmap
   v
Controlled Labs
   - VSFTPD 2.3.4
   - WebGoat
   - OWASP Juice Shop
```

## 2. User Interface Layer

WhatsApp provides a convenient remote interface to OpenClaw. Open WebUI provides a browser-based interface. These are interfaces, not the AI model itself.

## 3. AI Agent Layer

OpenClaw acts as the AI-agent/orchestration layer. It receives requests, interacts with configured AI models, and can use permitted tools.

Conceptually:

```text
User -> OpenClaw -> Model/Tool -> Result -> OpenClaw -> User
```

## 4. AI Provider Layer

The project intentionally uses multiple providers.

```text
Primary: OpenRouter Free
       |
       +-- unavailable/rate limited --> Gemini
                                      |
                                      +--> OpenCode Free
```

Examples tested during development include:

```text
openrouter/free
google/gemini-3.5-flash-lite
opencode/big-pickle
opencode/longcat-2.5-preview-free
opencode/mimo-v2.6-flash-free
opencode/nemotron-3.5-lightning-free
opencode/space-bunny-free
```

Availability and provider policies can change, so the documentation records what was actually tested.

## 5. Tool Execution Layer

The agent can use tools such as shell execution.

```text
User request
  -> OpenClaw
  -> Exec tool
  -> Linux shell
  -> command
  -> output
  -> OpenClaw
  -> user
```

This is a major security boundary because an agent with shell access can affect the host.

## 6. Docker Laboratory Layer

Docker provides isolated, reproducible application environments.

```text
Google Cloud VM
  -> Debian Linux
     -> Docker
        +-> VSFTPD 2.3.4
        +-> WebGoat
        +-> OWASP Juice Shop
```

## 7. VSFTPD Controlled Lab

The deliberately vulnerable VSFTPD laboratory uses localhost-only host mappings during testing:

```text
127.0.0.1:2121 -> container:21
127.0.0.1:6200 -> container:6200
```

This keeps the lab endpoints local to the host rather than intentionally exposing them as public Internet services.

## 8. Security Tool Integration

The project explores the chain:

```text
WhatsApp
  -> OpenClaw
  -> AI model
  -> Exec tool
  -> Linux
  -> Metasploit/Nmap/etc.
  -> controlled lab target
```

All offensive-security experiments are restricted to owned or explicitly authorized laboratory targets.

## 9. Development vs Runtime

The Windows host is the main development/documentation environment:

```text
Windows Host
  -> VS Code
  -> Git
  -> GitHub
  -> GitLab
```

The Google Cloud VM is the runtime laboratory:

```text
Google Cloud VM
  -> Debian
  -> OpenClaw
  -> Docker
  -> Security Tools
  -> Lab Targets
```

This separation keeps development and runtime responsibilities organized.

## 10. Network Boundary

The architecture distinguishes between public services and laboratory services.

A vulnerable service should not be Internet-facing when localhost access is sufficient.

Important principles:

- Prefer localhost bindings for local-only targets.
- Keep credentials out of Git.
- Avoid unnecessary public exposure.
- Separate deliberately vulnerable targets from production systems.
- Treat AI tool execution as privileged access.

## 11. Repository Architecture

```text
cloud-ai-cybersecurity-lab/
├── README.md
├── .gitignore
├── architecture/
├── configs/
├── docs/
│   ├── architecture.md
│   ├── concepts.md
│   ├── deployment.md
│   ├── free-resources.md
│   ├── security.md
│   └── testing.md
├── evidence/
├── labs/
└── scripts/
```

## 12. Future Architecture

The intended long-term direction is:

```text
Cloud
  |
  v
AI Agent
  |
  v
Security Tools
  |
  v
Security Data / Targets
  |
  v
AI-Assisted Analysis
  |
  v
Monitoring / Response
```

Possible future integrations include Wazuh, ELK, pfSense, AI-assisted alert analysis, investigation assistance, and controlled response automation.

## 13. Architectural Principles

1. Beginner-friendly documentation.
2. Free-first resource selection.
3. Modular components.
4. Reproducible deployment.
5. Secure boundaries where practical.
6. Test before declaring success.
7. Clearly distinguish planned, installed, tested, and validated components.
8. Authorized security testing only.

## 14. Current Status

Implemented/tested components include the Google Cloud VM, Debian, Docker, OpenClaw, multiple AI providers, free-model fallback routing, WhatsApp, Open WebUI, native command execution, Metasploit, and controlled vulnerable laboratory containers.

The architecture will continue to evolve as the laboratory is integrated with the existing Wazuh and ELK/pfSense projects.
