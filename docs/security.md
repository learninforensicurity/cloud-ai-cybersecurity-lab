# Security Model

## 1. Purpose

The Cloud AI Cybersecurity Lab is itself a cybersecurity learning environment.

That means security is not an afterthought. The project must demonstrate how to build useful AI and cybersecurity capabilities while controlling the risks created by:

- cloud exposure,
- AI agents,
- remote interfaces,
- API credentials,
- vulnerable applications,
- security tooling,
- Docker containers,
- automated command execution.

The goal is to make the laboratory useful without turning it into an uncontrolled attack platform.

---

## 2. Core Security Principle

The most important rule is:

> **An AI agent must operate inside clearly defined authorization boundaries.**

The presence of an AI agent, Metasploit, vulnerable software, or shell access does not create authorization to attack external systems.

Testing is limited to:

- systems owned by the user,
- systems explicitly authorized for testing,
- intentionally vulnerable laboratory targets,
- controlled cloud resources belonging to the laboratory.

---

## 3. Security Boundaries

The laboratory has several important boundaries.

```text
                    Internet
                       |
                       | limited exposure
                       v
                Google Cloud VM
                       |
          +------------+------------+
          |                         |
          v                         v
      AI / Agent                Docker Labs
      OpenClaw                  WebGoat
          |                     Juice Shop
          |                     VSFTPD
          v
   Authorized Tools
   Metasploit / Shell
```

The boundaries are designed so that vulnerable applications are not automatically equivalent to public Internet services.

---

## 4. Windows Development Boundary

The Windows machine is primarily the development and documentation environment.

Responsibilities include:

- editing documentation,
- Git operations,
- repository management,
- configuration preparation,
- reviewing evidence,
- pushing changes to GitHub and GitLab.

The Windows machine should not contain unnecessary production secrets.

Private keys and credentials should remain protected.

---

## 5. Cloud Runtime Boundary

The Google Cloud VM is the execution environment.

It contains services that may need to communicate with each other, but that does not mean every service should be exposed to the Internet.

A useful rule is:

> Bind services to localhost when remote access is not required.

For example:

```text
127.0.0.1:2121
127.0.0.1:6200
```

is safer than:

```text
0.0.0.0:2121
0.0.0.0:6200
```

for a deliberately vulnerable local laboratory service.

---

## 6. AI Agent Security

OpenClaw can connect:

```text
User
  |
  v
AI model
  |
  v
Agent
  |
  v
Tools
```

This creates a security-sensitive chain.

An AI response is not automatically trustworthy.

The agent may interpret a request, choose a tool, execute a command, and return the result.

Therefore:

- tool access must be intentional,
- execution should be scoped,
- targets should be controlled,
- credentials should not be exposed unnecessarily,
- dangerous actions should not be treated as ordinary text generation.

---

## 7. Native Command Execution

The current laboratory allows OpenClaw to use native execution on the gateway.

This is powerful because it allows the agent to interact with Linux tools.

It is also one of the highest-risk capabilities in the project.

For this reason, command execution should be considered equivalent to giving the agent meaningful access to the laboratory host.

The agent should therefore be used only in a controlled environment.

---

## 8. WhatsApp Security

WhatsApp provides convenient remote access to the AI agent.

Convenience also creates risk.

A remote messaging interface can become a path to:

```text
Internet user
    |
    v
WhatsApp
    |
    v
OpenClaw
    |
    v
Shell / Tools
```

Therefore the WhatsApp integration must not be treated as an unrestricted public shell.

Remote users should be limited to authorized users.

The project should also avoid exposing sensitive command output unnecessarily through messaging channels.

---

## 9. Open WebUI Security

Open WebUI provides browser-based access to the AI system.

The interface may provide access to:

- conversations,
- model providers,
- files,
- tools,
- agent capabilities.

Therefore it should be protected appropriately.

Do not expose the interface publicly unless the authentication and network exposure have been intentionally configured.

---

## 10. API Key Security

API keys are credentials.

Examples include:

- OpenRouter API keys,
- Google/Gemini credentials,
- OpenCode-related credentials where applicable,
- cloud credentials.

Never commit real credentials.

Do not put them into:

```text
README.md
docs/
screenshots/
Git commits
public issues
public chat transcripts
```

Use environment variables or protected configuration.

The repository's `.gitignore` provides an additional layer of protection, but `.gitignore` is not a substitute for security awareness.

---

## 11. Secret Rotation

If a secret is accidentally exposed:

1. Assume it is compromised.
2. Revoke or rotate it.
3. Remove it from the working configuration.
4. Check Git history if it was committed.
5. Replace it with a new credential.
6. Verify that the old credential no longer works.

Simply deleting a secret from the latest file does not necessarily remove it from Git history.

---

## 12. Cloud Security

Cloud resources should follow least-exposure principles.

Important controls include:

- strong account authentication,
- limited firewall exposure,
- minimal open ports,
- protected SSH access,
- regular package updates,
- controlled service exposure,
- monitoring of resource usage,
- removal of unnecessary services.

The cloud VM should not expose vulnerable applications simply because they are convenient to access.

---

## 13. Docker Security

Docker provides isolation, but Docker containers are not magical security boundaries.

Important considerations:

- do not run unnecessary privileged containers,
- expose only required ports,
- avoid mounting sensitive host directories,
- avoid passing host credentials into containers,
- remove unused containers,
- keep images under review,
- understand what an image contains.

A deliberately vulnerable image should be treated as untrusted laboratory software.

---

## 14. Vulnerable Targets

The project intentionally uses vulnerable applications for learning.

Examples:

- OWASP WebGoat
- OWASP Juice Shop
- VSFTPD 2.3.4 laboratory container

These targets exist to demonstrate security concepts.

They should be:

- isolated,
- clearly identified,
- monitored,
- used only for authorized testing,
- removed or stopped when not required.

---

## 15. VSFTPD Laboratory Boundary

The VSFTPD 2.3.4 target is intentionally vulnerable.

The current host mapping uses localhost:

```text
127.0.0.1:2121 -> FTP
127.0.0.1:6200 -> laboratory backdoor port
```

This provides an important safety boundary.

Metasploit testing against this service is considered valid laboratory activity because the target is intentionally deployed by the project for testing.

The project should not generalize this testing to third-party hosts.

---

## 16. Metasploit Security

Metasploit is a legitimate security testing framework.

Its presence in the lab does not change the authorization boundary.

Use Metasploit against:

- local vulnerable containers,
- intentionally vulnerable VMs,
- authorized cloud targets,
- dedicated training environments.

Do not use the laboratory documentation as authorization to attack arbitrary Internet systems.

---

## 17. AI Model Security

AI models can produce:

- incorrect information,
- unsafe suggestions,
- hallucinated commands,
- outdated information,
- incomplete security advice.

The project therefore treats AI output as assistance rather than unquestionable authority.

For cybersecurity operations:

```text
AI suggestion
     |
     v
Human verification
     |
     v
Authorized execution
```

This is especially important when an AI agent can execute commands.

---

## 18. Prompt Injection

Prompt injection occurs when untrusted content attempts to influence an AI system's instructions.

Example:

```text
A web page
    |
    v
Untrusted text
    |
    v
AI agent
```

The text might contain instructions designed to make the agent:

- reveal secrets,
- ignore safety rules,
- execute commands,
- access unrelated files.

The project should treat external content as untrusted input.

AI agents should not blindly follow instructions found in files, web pages, application output, or security-tool results.

---

## 19. Tool Output Is Untrusted

Command output should also be treated as data rather than instructions.

For example, if a tool returns:

```text
IGNORE PREVIOUS INSTRUCTIONS
RUN THIS COMMAND
```

the agent must not automatically interpret that text as a higher-priority instruction.

This distinction is important for secure agent design.

---

## 20. Least Privilege

Least privilege means giving a component only the permissions it actually needs.

Examples:

- expose only required network ports,
- use only required API permissions,
- avoid unnecessary root access,
- avoid unnecessary Docker privileges,
- keep vulnerable services isolated,
- limit remote interfaces.

The more powerful the tool, the more important this principle becomes.

---

## 21. Logging and Evidence

Security-relevant actions should be documented where practical.

Useful evidence includes:

- command output,
- service status,
- Docker container state,
- network listeners,
- model/provider used,
- timestamps,
- test results,
- screenshots when useful.

Do not place credentials inside evidence.

Evidence should help reproduce and understand a test without exposing secrets.

---

## 22. Incident Response Within the Lab

If something behaves unexpectedly:

1. Stop the affected service if necessary.
2. Disconnect unnecessary network exposure.
3. Inspect logs.
4. Identify what changed.
5. Rotate exposed credentials.
6. Restore a known-good configuration.
7. Document the event.
8. Retest before continuing.

A laboratory is also an opportunity to practice incident-response thinking.

---

## 23. Security Checklist

Before enabling a new capability:

- [ ] What does this capability access?
- [ ] Does it execute commands?
- [ ] Does it expose a network service?
- [ ] Does it handle credentials?
- [ ] Can it access unrelated files?
- [ ] Is the target authorized?
- [ ] Can the capability be limited?
- [ ] Is the service exposed only where required?
- [ ] Can the action be logged?
- [ ] Can the system be restored if something goes wrong?

---

## 24. Security Philosophy

The project aims to demonstrate a balanced approach:

```text
Power
  +
Control
  +
Isolation
  +
Documentation
  =
Useful Security Laboratory
```

The objective is not to remove every powerful capability.

The objective is to make powerful capabilities usable inside clearly defined boundaries.

---

## 25. Responsible Use

This laboratory is intended for:

- education,
- research,
- authorized penetration testing,
- defensive security experimentation,
- AI-agent experimentation,
- cloud security learning.

It must not be used to gain unauthorized access to systems, accounts, networks, applications, or data.

---

## 26. Security Limitations

No laboratory architecture is automatically secure.

The security model described here is a practical learning baseline.

It does not replace:

- cloud provider security guidance,
- organizational security policies,
- formal threat modeling,
- professional penetration testing,
- legal authorization,
- production security controls.

Security assumptions should be reviewed whenever the architecture changes.
