# WhatsApp and Open WebUI Integration

## Purpose

The project provides two user-facing interfaces:

```text
WhatsApp
Open WebUI
```

They serve different use cases while connecting to the same AI laboratory.

## WhatsApp

WhatsApp is useful for:

- mobile access,
- remote interaction,
- quick commands,
- observing model fallback behavior.

Current OpenClaw responses can include:

```text
[Model: {modelFull}]
```

This identifies the backend model where configured.

## Safe Baseline

A harmless test is:

```text
hostname && whoami && pwd
```

This confirms that:

- the message reaches OpenClaw,
- tool execution works,
- the result comes from the laboratory runtime.

## Open WebUI

Open WebUI provides browser-based AI interaction.

Current access pattern:

```text
http://<LAB-IP>:3000
```

The exact address depends on the current cloud environment.

## Why Both?

```text
WhatsApp
   |
   +--> convenient remote interface

Open WebUI
   |
   +--> browser interface
```

Using both also provides a useful integration test.

If one interface fails, the other can help determine whether the problem is the interface or the underlying AI/runtime layer.

## Security

Neither interface should be treated as an unrestricted public shell.

The interfaces ultimately connect to a runtime where command execution is enabled.

Therefore:

- use authorized accounts,
- protect authentication,
- avoid public exposure unless intentional,
- do not send secrets through ordinary chat,
- review command/tool permissions.

## Testing Matrix

| Test | WhatsApp | Open WebUI |
|---|---|---|
| Normal AI prompt | Yes | Yes |
| Model identification | Yes | Where supported |
| Safe hostname command | Yes | Where tool access is configured |
| Fallback observation | Yes | Yes |
| Security-tool workflow | Controlled | Controlled |

## Troubleshooting

### WhatsApp fails

Check:

```bash
systemctl status openclaw-gateway --no-pager
```

Then test OpenClaw independently.

### Open WebUI fails

Check:

```bash
docker ps
```

Then inspect the Open WebUI container.

### AI fails in both

Check model/provider availability and fallback routing.

This layered diagnosis prevents blaming the user interface for an AI provider failure.
