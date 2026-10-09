# Phase 3 Implementation

## 1. What Phase 3 Does

Phase 2 documented the architecture.

Phase 3 begins turning that architecture into a maintainable configuration structure.

The key objective is:

> Keep the real runtime operational while making the configuration understandable, reproducible, and safe to version-control.

---

## 2. Files Added in Phase 3

```text
configs/
├── .env.example
├── docker-lab.env.example
└── model-routing.env.example

docs/
├── model-routing.md
├── phase3-implementation.md
└── runtime-configuration.md

scripts/
├── health-check.ps1
└── health-check.sh
```

These are templates and documentation.

They intentionally do not contain real credentials.

---

## 3. Why Example Files?

The repository is public.

Real credentials must therefore remain outside Git.

The project uses:

```text
example configuration
        +
protected runtime configuration
```

instead of:

```text
real secrets in Git
```

---

## 4. Minimal Runtime Work

Most of Phase 3 can be completed without rebuilding the cloud VM.

The repository-side work is:

1. Add the new files.
2. Review them.
3. Commit them.
4. Push to GitHub and GitLab.

The runtime-side work is deliberately limited to validation.

---

## 5. Runtime Validation

On the GCP VM, run:

```bash
openclaw --version
```

Then:

```bash
systemctl status openclaw-gateway --no-pager
```

Then:

```bash
docker ps
```

Then:

```bash
ss -lntp
```

Finally run the supplied:

```bash
scripts/health-check.sh
```

The script is informational and should not modify the system.

---

## 6. Windows Validation

From the repository directory:

```powershell
.\scripts\health-check.ps1
```

If PowerShell execution policy prevents the script from running, use:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\health-check.ps1
```

This script checks only the development/repository side.

---

## 7. What Is Deliberately Not Automated

The project does not automatically overwrite:

- OpenClaw live configuration,
- API credentials,
- cloud firewall rules,
- Docker production state,
- WhatsApp authentication state,
- Open WebUI data.

This is intentional.

Automating these operations without first validating the installed software version could break the working laboratory.

---

## 8. Model Routing

The model-routing documentation records the currently tested free-first order.

The project should update the table when:

- a provider changes limits,
- a model disappears,
- a new free model is validated,
- a provider becomes unreliable,
- a paid model becomes necessary.

---

## 9. Configuration Change Policy

Before changing a live configuration:

```text
Backup
  |
  v
Change one logical component
  |
  v
Validate
  |
  v
Test
  |
  v
Record
  |
  v
Commit documentation/config template
```

This reduces troubleshooting complexity.

---

## 10. Security Rule

Never convert an example configuration into a public credential store.

In particular, do not replace:

```text
OPENROUTER_API_KEY=
```

with a real key and then commit the file.

Use the local runtime's protected configuration instead.

---

## 11. Phase 3 Completion Criteria

Phase 3 is considered complete when:

- [ ] runtime configuration is documented,
- [ ] model routing is documented,
- [ ] safe environment templates exist,
- [ ] Docker lab configuration template exists,
- [ ] Windows health-check script exists,
- [ ] Linux health-check script exists,
- [ ] no real credentials are present,
- [ ] existing runtime continues working,
- [ ] all new files are committed,
- [ ] GitHub and GitLab contain the same commit.

---

## 12. Phase 3 Boundary

Phase 3 establishes configuration structure.

It does not yet attempt to fully automate cloud provisioning.

That is a future phase because cloud provisioning should be introduced only after the existing runtime has been documented and tested.

This keeps the project stable while progressively increasing automation.
