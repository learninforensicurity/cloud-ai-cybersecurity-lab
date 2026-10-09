# Runtime Integration

## 1. Purpose

This document explains how the actual laboratory components work together.

The project combines:

- cloud infrastructure,
- AI,
- messaging,
- browser-based AI access,
- Docker,
- vulnerable applications,
- security tooling.

The integration is intentionally layered.

## 2. High-Level Flow

```text
                    +----------------+
                    |    WhatsApp   |
                    +-------+--------+
                            |
                            v
                    +---------------+
                    |    OpenClaw   |
                    |    Gateway    |
                    +-------+-------+
                            |
                +-----------+-----------+
                |                       |
                v                       v
        +---------------+       +---------------+
        | AI Providers  |       | Tool Execution|
        | + Fallbacks   |       |   Gateway     |
        +---------------+       +-------+-------+
                                        |
                         +--------------+--------------+
                         |                             |
                         v                             v
                    Docker Labs                  Metasploit
                         |
              +----------+----------+
              |          |          |
              v          v          v
          WebGoat   Juice Shop   VSFTPD
```

Open WebUI provides a second browser-oriented interface into the AI environment.

## 3. User Interfaces

### WhatsApp

WhatsApp is the remote/mobile interface.

A user sends a request.

```text
WhatsApp
   |
   v
OpenClaw
```

OpenClaw processes the request and may call the configured AI model or an authorized tool.

### Open WebUI

Open WebUI provides browser-based interaction.

```text
Browser
   |
   v
Open WebUI
   |
   v
AI runtime
```

The two interfaces serve different purposes but connect to the same broader laboratory architecture.

## 4. OpenClaw

OpenClaw is the orchestration/agent layer.

It connects:

```text
User
 |
 v
Agent
 |
 +--> AI model
 |
 +--> authorized command/tool execution
```

Because command execution is enabled in the current laboratory, OpenClaw should be treated as a privileged laboratory component.

## 5. AI Provider Layer

The project uses a free-first model strategy.

Current routing is documented in:

```text
docs/model-routing.md
```

The important architectural principle is:

```text
Primary model
     |
     v
Fallbacks
```

Temporary provider failures should not necessarily make the whole laboratory unavailable.

## 6. Tool Execution

OpenClaw can execute authorized commands on the gateway.

Examples already validated in the laboratory include:

```text
id
hostname && whoami && pwd
which msfconsole
```

These are safe baseline tests.

The ability to execute commands is deliberately kept inside the controlled cloud laboratory.

## 7. Docker Integration

Docker provides the laboratory application layer.

The agent can interact with the host and the laboratory tools according to its configured permissions.

Docker targets should not be interpreted as automatically safe simply because they are containers.

The project uses network boundaries and explicit port mappings to control exposure.

## 8. WebGoat and Juice Shop

WebGoat and Juice Shop are intentionally vulnerable web applications.

They provide training targets for learning:

- web application security,
- vulnerabilities,
- HTTP behavior,
- reconnaissance,
- testing,
- defensive analysis.

They should remain authorized laboratory targets.

## 9. VSFTPD Integration

The VSFTPD 2.3.4 container is a deliberately vulnerable FTP target.

Current localhost mappings:

```text
127.0.0.1:2121 -> 21
127.0.0.1:6200 -> 6200
```

Metasploit can be used against this locally deployed target for controlled experimentation.

## 10. Metasploit Integration

Metasploit is a security testing framework.

The integration is:

```text
OpenClaw
   |
   v
Linux command execution
   |
   v
msfconsole
   |
   v
authorized lab target
```

A successful command execution does not imply that a specific exploit will succeed.

This distinction is documented in the testing guide.

## 11. Security Boundary

The intended boundary is:

```text
Remote user
     |
     v
AI interface
     |
     v
OpenClaw
     |
     v
Cloud VM
     |
     +--> controlled Docker target
     |
     +--> authorized security tooling
```

The system must not be used to attack unrelated Internet systems.

## 12. Integration Test Sequence

Use this order:

1. Confirm the VM is healthy.
2. Confirm Docker.
3. Confirm OpenClaw.
4. Confirm Open WebUI.
5. Confirm WhatsApp.
6. Test a harmless OpenClaw command.
7. Test model identification.
8. Test primary/fallback model behavior.
9. Confirm Docker targets.
10. Confirm network listeners.
11. Test only authorized security-tool workflows.

## 13. Failure Isolation

If WhatsApp fails:

```text
WhatsApp
   X
OpenClaw
```

Test OpenClaw independently.

If AI fails:

```text
OpenClaw
   |
   X
AI provider
```

Test provider/fallback routing.

If a Docker target fails:

```text
OpenClaw
   |
   v
Docker
   |
   X
Target
```

Test the container independently.

This layered approach prevents unrelated failures from being confused with each other.

## 14. Integration Principle

The project should always answer:

> Which component failed?

rather than simply:

> The lab is broken.

This makes the system easier for beginners to troubleshoot.
