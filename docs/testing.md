# Testing Guide

## 1. Purpose

Testing verifies that the Cloud AI Cybersecurity Lab works as intended and that changes do not silently break important capabilities.

The testing process covers:

- infrastructure,
- Docker,
- OpenClaw,
- AI model routing,
- WhatsApp,
- Open WebUI,
- cybersecurity tools,
- vulnerable laboratory targets,
- security boundaries,
- documentation and Git integrity.

The goal is not simply to prove that a command works once.

The goal is to create repeatable evidence that the laboratory is functioning correctly.

---

## 2. Testing Philosophy

The project uses a layered testing approach:

```text
Layer 1  Operating System
Layer 2  Docker
Layer 3  Application Services
Layer 4  AI / OpenClaw
Layer 5  User Interfaces
Layer 6  Cybersecurity Tools
Layer 7  Controlled Targets
Layer 8  Security Boundaries
Layer 9  Documentation / Git
```

If a lower layer fails, higher-layer testing may produce misleading results.

Therefore testing should normally proceed from the bottom upward.

---

## 3. Test Environment

The main runtime environment is a Google Cloud Debian VM.

The development environment is Windows with:

- VS Code
- Git
- GitHub
- GitLab

The cloud VM is the primary runtime target for functional tests.

---

## 4. Test Categories

### Functional testing

Does the service work?

### Connectivity testing

Can the expected components communicate?

### Security testing

Are services exposed only where intended?

### Integration testing

Do multiple components work together?

### Availability testing

Does the fallback model/provider strategy continue working when a provider is unavailable?

### Regression testing

Did a new change break an existing capability?

---

## 5. Operating System Baseline

Start by recording basic system information.

```bash
uname -a
cat /etc/os-release
hostname
whoami
pwd
```

Expected result:

- correct Linux host,
- expected hostname,
- expected user,
- expected working directory.

This establishes which machine is being tested.

---

## 6. Resource Baseline

Check:

```bash
nproc
free -h
df -h /
```

These commands record:

- CPU availability,
- memory usage,
- disk capacity.

This is useful because AI services and Docker workloads can consume significant resources.

---

## 7. Docker Test

Verify Docker:

```bash
docker version
docker info
docker ps
```

Expected result:

- Docker client is available,
- Docker engine is reachable,
- expected containers are running.

If Docker is unavailable, troubleshoot Docker before testing applications that depend on it.

---

## 8. Container Inventory

Record the active containers:

```bash
docker ps
```

For a more detailed view:

```bash
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"
```

The inventory should identify expected services such as:

- Open WebUI
- WebGoat
- Juice Shop
- VSFTPD laboratory container

The exact list may change as the project evolves.

---

## 9. Open WebUI Test

Verify that the container is running:

```bash
docker ps
```

Then open the configured browser endpoint.

Test:

1. Page loads.
2. Authentication works if enabled.
3. Model selection is available.
4. A normal AI request receives a response.
5. The expected backend model can be identified where configured.

Do not record API keys or passwords as evidence.

---

## 10. OpenClaw Service Test

Check the service:

```bash
systemctl status openclaw-gateway
```

Expected:

```text
active (running)
```

Also verify the local gateway listener:

```bash
ss -lntp | grep 18789
```

The gateway should normally be bound to the intended local interface.

---

## 11. OpenClaw Functional Test

Send a harmless request through the configured user interface.

Examples:

```text
What is the hostname of the laboratory server?
```

or:

```text
Run hostname && whoami && pwd
```

The expected result should demonstrate that:

- the request reaches OpenClaw,
- the agent can use the configured tool,
- the result comes from the laboratory host.

Do not use destructive commands as functional tests.

---

## 12. Model Routing Test

The project intentionally uses multiple free model/provider options.

A routing test should verify:

1. Primary model is available.
2. A normal request succeeds.
3. The backend model is visible where configured.
4. A fallback can be selected when the primary provider is unavailable.
5. The response is still returned.

The current free-first routing is documented in:

```text
docs/free-resources.md
```

---

## 13. HTTP 429 Testing

Free AI providers can return:

```text
HTTP 429
```

This normally indicates that a rate or quota limit has been reached.

A 429 should not automatically be interpreted as a configuration failure.

The project intentionally uses fallback providers to reduce the impact of temporary rate limits.

Record:

- provider,
- model,
- timestamp,
- error,
- fallback selected,
- result.

This creates useful evidence about real-world availability.

---

## 14. WhatsApp Test

The WhatsApp interface should be tested with harmless commands.

Example:

```text
id
```

Expected:

- OpenClaw receives the message,
- the agent executes the authorized command,
- a response is returned.

Additional safe tests:

```text
hostname && whoami && pwd
```

and:

```text
which msfconsole
```

These tests verify different aspects of the runtime without attacking a target.

---

## 15. Model Identification Test

The project can display the backend model in WhatsApp responses when configured.

A test should verify that the response prefix identifies the actual model/provider.

This is valuable because fallback routing can otherwise be invisible to the user.

Example conceptual output:

```text
[Model: provider/model]
response...
```

The exact model name can change as the project evolves.

---

## 16. Metasploit Test

Verify installation:

```bash
which msfconsole
msfconsole --version
```

Expected:

- executable is present,
- Metasploit starts,
- version information is returned.

This is an installation test, not an exploitation test.

---

## 17. Controlled VSFTPD Test

The vulnerable VSFTPD laboratory is intentionally local.

Check:

```bash
docker ps
```

Then verify the expected host listeners:

```bash
ss -lntp | grep -E '2121|6200'
```

Expected:

```text
127.0.0.1:2121
127.0.0.1:6200
```

This confirms the service is reachable only through the intended localhost bindings.

---

## 18. TCP Connectivity Test

A simple connectivity test can be performed with:

```bash
nc -v 127.0.0.1 6200
```

Successful TCP connectivity proves that the port is reachable.

It does not prove that an exploit will succeed.

This distinction is important.

```text
Port reachable
       !=
Exploit successful
```

---

## 19. Metasploit Laboratory Test

The VSFTPD laboratory can be used to study controlled exploitation behavior.

The intended target is:

```text
127.0.0.1:2121
```

Testing should remain limited to the locally deployed vulnerable container.

The project has observed that the VSFTPD module may detect that the backdoor port is already open and may abort rather than provide a shell.

This should be documented as a laboratory observation rather than incorrectly reported as a successful exploit.

The important test result is:

- OpenClaw command execution works.
- Network connectivity to the local laboratory works.
- Metasploit is installed and executable.
- The specific exploit behavior is target/module dependent.

---

## 20. WebGoat Test

Verify the WebGoat container:

```bash
docker ps
```

Confirm its published port.

Then access the configured WebGoat browser interface.

Testing should verify:

- application loads,
- login or initial setup works if required,
- training pages are accessible,
- the application is not unintentionally exposed to the public Internet.

---

## 21. Juice Shop Test

Verify:

```bash
docker ps
```

Then open the configured Juice Shop interface.

Test:

- application loads,
- normal pages respond,
- training functionality is available,
- network exposure matches the intended lab design.

Juice Shop is intentionally vulnerable and should remain a controlled target.

---

## 22. Network Exposure Test

Review listeners:

```bash
ss -lntp
```

For Docker:

```bash
docker ps --format "table {{.Names}}\t{{.Ports}}"
```

Look for unexpected:

```text
0.0.0.0:<port>
```

or:

```text
:::<port>
```

bindings.

A service that should be local-only should preferably use:

```text
127.0.0.1:<port>
```

This is one of the most important recurring security tests.

---

## 23. Cloud Firewall Test

Review Google Cloud firewall rules before exposing a new service.

The exact commands depend on the current Google Cloud configuration.

The principle is:

```text
Only required traffic
        |
        v
Allowed
```

Everything else should remain closed unless there is a specific reason to expose it.

---

## 24. Secret Safety Test

Before every Git commit, check for accidental secrets.

Review:

```bash
git status
```

Then inspect staged files:

```bash
git diff --cached
```

Useful checks include searching for:

```text
API keys
passwords
tokens
private keys
service-account credentials
```

The project `.gitignore` reduces the chance of accidental commits but does not replace manual review.

---

## 25. Git Integrity Test

Before committing documentation:

```bash
git status
git diff --check
```

After staging:

```bash
git diff --cached --check
```

Expected:

- no unintended files,
- no whitespace errors,
- no secrets,
- documentation changes are intentional.

---

## 26. GitHub/GitLab Synchronization Test

The project maintains both GitHub and GitLab remotes.

Check:

```bash
git remote -v
```

After pushing:

```bash
git ls-remote github refs/heads/main
git ls-remote gitlab refs/heads/main
```

Both should point to the same commit hash.

Conceptually:

```text
                 +--> GitHub
Local Git -------|
                 +--> GitLab
```

This provides redundancy and demonstrates multi-remote Git workflows.

---

## 27. Regression Testing

After changing a major component, rerun the relevant baseline tests.

For example, after changing OpenClaw configuration:

1. Check the service.
2. Test a harmless local command.
3. Test WhatsApp.
4. Test Open WebUI.
5. Test model routing.
6. Verify security boundaries.
7. Record the result.

Do not assume that a configuration change affects only the setting that was edited.

---

## 28. Evidence Collection

Useful evidence may include:

```text
system information
Docker status
service status
network listeners
model/provider responses
WhatsApp test results
Open WebUI screenshots
Metasploit version
controlled target status
Git commit hashes
```

Evidence should be:

- timestamped where practical,
- clearly labeled,
- reproducible,
- free of credentials.

Store sensitive evidence outside public Git when necessary.

---

## 29. Test Result Format

A simple test record can use:

| Field | Example |
|---|---|
| Test | OpenClaw command execution |
| Date | YYYY-MM-DD |
| Environment | GCP Debian VM |
| Command/Input | `hostname && whoami && pwd` |
| Expected | Host information returned |
| Actual | Result returned |
| Status | PASS |
| Notes | Executed through WhatsApp |

This makes the project easier for another learner to understand.

---

## 30. Suggested Test Statuses

Use simple statuses:

- `PASS` — expected behavior confirmed.
- `FAIL` — expected behavior did not occur.
- `BLOCKED` — test could not proceed because of a dependency.
- `NOT TESTED` — test has not yet been performed.
- `PARTIAL` — some expected behavior worked but the complete test did not.

Avoid marking a test `PASS` merely because a command ran.

---

## 31. Baseline Test Checklist

### Infrastructure

- [ ] OS verified
- [ ] CPU/RAM/disk recorded
- [ ] Docker healthy
- [ ] Expected containers running

### AI

- [ ] OpenClaw gateway active
- [ ] Primary AI provider tested
- [ ] Fallback tested
- [ ] Model identification verified
- [ ] Rate-limit behavior documented

### Interfaces

- [ ] WhatsApp tested
- [ ] Open WebUI tested

### Cybersecurity

- [ ] Metasploit installed
- [ ] WebGoat tested
- [ ] Juice Shop tested
- [ ] VSFTPD laboratory tested

### Security

- [ ] Network listeners reviewed
- [ ] Cloud firewall reviewed
- [ ] Secrets reviewed
- [ ] Vulnerable services remain controlled

### Git

- [ ] `git diff --check`
- [ ] staged diff reviewed
- [ ] commit created
- [ ] GitHub updated
- [ ] GitLab updated
- [ ] remote commit hashes match

---

## 32. Testing Philosophy in Practice

The project should prefer evidence over assumptions.

Instead of:

> “The service should be working.”

record:

> “The service was checked at this time, the expected command was executed, and the observed result was recorded.”

This approach turns the laboratory into a reproducible technical project rather than a collection of undocumented experiments.

---

## 33. Important Limitation

Testing results describe the environment at the time of testing.

AI provider availability, model IDs, cloud resources, Docker images, OpenClaw behavior, network configuration, and application versions can change.

When a result becomes outdated, update the documentation and evidence rather than assuming the old result remains valid.
