# Phase 4 Laboratory Guide

## Objective

Phase 4 integrates the real runtime components already built during the project.

The laboratory now has four major functional paths:

```text
1. WhatsApp -> OpenClaw -> AI
2. Open WebUI -> AI
3. OpenClaw -> authorized Linux tools
4. Security tools -> controlled Docker targets
```

## 1. Pre-Flight

On the GCP VM:

```bash
hostname
whoami
docker ps
systemctl status openclaw-gateway --no-pager
ss -lntp
which msfconsole
```

All expected components should be identified before testing.

## 2. WhatsApp Baseline

Send a harmless request through WhatsApp:

```text
hostname && whoami && pwd
```

Expected:

- OpenClaw receives the request.
- The authorized execution tool runs.
- The cloud VM returns the result.
- The configured model prefix identifies the backend model when enabled.

## 3. Open WebUI Baseline

Open:

```text
http://<LAB-IP>:3000
```

Verify:

- interface loads,
- authentication behaves as configured,
- AI request works,
- selected/actual model can be identified where supported.

## 4. AI Fallback Baseline

Test a normal request.

Record:

```text
provider
model
result
date/time
```

If the primary provider returns HTTP 429, allow the configured fallback strategy to operate where supported.

Do not immediately spend paid credits just because a free provider is temporarily rate-limited.

## 5. Docker Baseline

Run:

```bash
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"
```

Identify:

- Open WebUI
- WebGoat
- Juice Shop
- VSFTPD laboratory

## 6. WebGoat

Access the configured WebGoat endpoint.

Confirm the application loads.

Use only the training exercises provided by the application.

## 7. Juice Shop

Access the configured Juice Shop endpoint.

Confirm the application loads.

Use it as an intentionally vulnerable training target.

## 8. VSFTPD

Confirm:

```bash
ss -lntp | grep -E ':(2121|6200)[[:space:]]'
```

Expected local bindings:

```text
127.0.0.1:2121
127.0.0.1:6200
```

Connectivity:

```bash
nc -v 127.0.0.1 6200
```

Successful TCP connectivity confirms the port is reachable.

It does not prove exploitation.

## 9. Metasploit

Verify:

```bash
which msfconsole
msfconsole --version
```

Only use Metasploit against the locally deployed vulnerable target or another explicitly authorized target.

## 10. Evidence

For each test record:

```text
Date/time
Component
Input/command
Expected result
Actual result
PASS/FAIL/PARTIAL
Notes
```

Do not record credentials.

## 11. Phase 4 Success Criteria

Phase 4 is complete when:

- [ ] runtime inventory documented
- [ ] OpenClaw integration documented
- [ ] WhatsApp integration documented
- [ ] Open WebUI integration documented
- [ ] AI fallback documented
- [ ] Docker targets documented
- [ ] Metasploit integration documented
- [ ] localhost VSFTPD boundary documented
- [ ] baseline tests documented
- [ ] no credentials committed
- [ ] runtime remains operational

## 12. Safety

All security testing must remain within authorized laboratory boundaries.

The purpose of this phase is to demonstrate integration and repeatability, not to provide unrestricted attack capability.
