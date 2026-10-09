# AI Model Routing

## 1. Purpose

This document records the project's current free-first AI routing strategy.

The project does not depend on one model or one provider.

Instead, it uses multiple providers/models so that temporary:

- rate limits,
- outages,
- provider changes,
- model removals,
- free-tier restrictions

do not necessarily stop the laboratory.

---

## 2. Current Routing Order

The tested routing order is:

| Priority | Model | Role |
|---:|---|---|
| 1 | `openrouter/free` | Primary free routing |
| 2 | `google/gemini-3.5-flash-lite | Fallback |
| 3 | `opencode/big-pickle` | Fallback |
| 4 | `opencode/longcat-2.5-preview-free` | Fallback |
| 5 | `opencode/mimo-v2.6-flash-free` | Fallback |
| 6 | `opencode/nemotron-3.5-lightning-free` | Fallback |
| 7 | `opencode/space-bunny-free` | Fallback |

This is a snapshot of the configuration tested during development.

---

## 3. Why Multiple Models?

A free model can be useful but still have:

```text
limited quota
temporary 429
maintenance
provider outage
model retirement
capacity limitations
```

Therefore:

```text
Availability > attachment to one model
```

The project intentionally values continuity.

---

## 4. Fallback Concept

Suppose the primary provider returns:

```text
HTTP 429
```

The router should attempt the next configured model where supported.

Conceptually:

```text
User request
     |
     v
openrouter/free
     |
     +--> success --> response
     |
     +--> unavailable
              |
              v
       Gemini fallback
              |
              +--> success --> response
              |
              v
       OpenCode fallback
              |
              v
             ...
```

---

## 5. What 429 Means

HTTP 429 commonly means:

```text
Too Many Requests
```

In a free AI service this can indicate that a usage limit has been reached.

It does not necessarily mean:

- the API key is invalid,
- the model is broken,
- the entire system is broken.

Always inspect the provider error before changing configuration.

---

## 6. Model Identification

The project displays the backend model in WhatsApp responses using:

```text
[Model: {modelFull}]
```

This is useful evidence.

For example, if the primary model becomes unavailable and a fallback responds, the user can see which model handled the request.

---

## 7. Testing a Model

For each model, record:

```text
Provider
Model ID
Date tested
Request type
Result
Latency impression
Rate-limit behavior
Availability
Role in routing
```

Do not record API credentials.

---

## 8. Availability Record

Use this template:

| Field | Value |
|---|---|
| Provider | |
| Model | |
| Date tested | |
| Status | PASS / FAIL / 429 / BLOCKED |
| Approx. response time | |
| Intended role | |
| Notes | |

This creates a historical record without claiming permanent availability.

---

## 9. Free-First Decision Rule

The project uses this decision order:

```text
Open source/self-hosted
        |
        v
Free API/model tier
        |
        v
Free cloud resource/credit
        |
        v
Paid service only if necessary
```

The objective is to reduce financial barriers, not to pretend that paid services never have value.

---

## 10. OpenRouter

Role:

```text
Primary free model-routing layer
```

Current primary:

```text
openrouter/free
```

The project should preserve paid OpenRouter credit unless there is a deliberate reason to consume it.

Paid usage is not required merely because a free model temporarily returns 429.

---

## 11. Gemini

Role:

```text
Free fallback
```

Current tested model:

```text
google/gemini-3.5-flash-lite
```

The project has observed that free provider quotas can also produce 429 responses.

Therefore Gemini is a fallback, not an unlimited guarantee.

---

## 12. OpenCode Zen

Role:

```text
Additional free fallback capacity
```

Current tested models:

```text
opencode/big-pickle
opencode/longcat-2.5-preview-free
opencode/mimo-v2.6-flash-free
opencode/nemotron-3.5-lightning-free
opencode/space-bunny-free
```

The availability of these models must be periodically revalidated.

---

## 13. Routing and Security

Model fallback must not weaken security boundaries.

Changing the model should not change:

- authorized targets,
- Docker isolation,
- secret handling,
- network restrictions,
- command authorization.

The model is one layer of the system.

Security boundaries belong to the runtime architecture.

---

## 14. Routing and Cost

The router should prefer free models when available.

The project should record meaningful paid usage separately.

Example:

```text
Provider: OpenRouter
Model: paid model
Reason: required capability
Cost: recorded
Date: recorded
```

This keeps the project financially transparent.

---

## 15. Routing Maintenance

When a model stops working:

1. Record the failure.
2. Check whether the provider changed availability or limits.
3. Test the next fallback.
4. Update the routing documentation.
5. Change the live configuration only after validation.
6. Record the new tested order.

Do not silently replace a model and lose the historical record.

---

## 16. Current Limitation

Model names, free tiers, quotas, routing behavior, and provider policies can change.

Therefore the routing table is a **tested project snapshot**, not a permanent guarantee.
