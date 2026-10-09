# Free Resources and Cost Strategy

## Purpose

A central goal of the Cloud AI Cybersecurity Lab is to make practical experimentation accessible to students, researchers, and cybersecurity learners without requiring expensive subscriptions.

The project therefore follows a **free-first** strategy.

This does not mean that every service is guaranteed to remain free forever. Free models, quotas, cloud credits, and provider policies can change. The project documents what was available and tested at the time of implementation.

---

# 1. Our Free-First Decision Process

When the project needs a new capability, we generally evaluate options in this order:

```text
Need a capability
       |
       v
Open-source solution available?
       |
      Yes
       |
       v
Use it

If not:
       |
       v
Free API/model tier available?
       |
      Yes
       |
       v
Use the free tier

If not:
       |
       v
Can we self-host it?
       |
      Yes
       |
       v
Self-host it

If not:
       |
       v
Can free cloud tier/credit provide it?
       |
      Yes
       |
       v
Use it carefully

If none of the above:
       |
       v
Evaluate a paid service
```

The objective is to minimize cost without pretending that a free service is unlimited.

---

# 2. Important Cost Terminology

## Completely Free

A resource can be used without payment under the stated conditions.

## Free Tier

A provider allows a limited amount of usage at no monetary cost.

The free tier may have:

- Request limits
- Token limits
- Rate limits
- Model restrictions
- Time restrictions
- Fair-use policies

## Promotional Credit

A cloud provider may provide credits that can be consumed by resources that would otherwise be billable.

Promotional credit is **not the same thing as permanent free hosting**.

## Paid

Actual payment is required after applicable free usage or credits are exhausted.

---

# 3. AI Provider Strategy

The laboratory intentionally avoids depending on a single AI provider.

Our tested provider categories include:

```text
OpenRouter
Google Gemini
OpenCode Zen
```

The reason is simple:

> A free provider may become rate-limited or temporarily unavailable.

Using several providers allows the project to continue experimenting without immediately switching to paid services.

---

# 4. OpenRouter

## What is OpenRouter?

OpenRouter provides an API interface through which applications can access multiple AI models.

The project uses:

```text
openrouter/free
```

as the primary model route where available.

## Why use it?

The free route can provide access to models without requiring us to purchase credits for every request.

## Important limitation

Free model availability and quotas can change.

During testing, the free route experienced HTTP `429` rate limiting. Instead of immediately purchasing credits, we used the project's fallback providers.

This is an intentional part of the project's cost-control strategy.

---

# 5. Google Gemini

## What is Gemini?

Gemini is Google's family of generative AI models.

The project configured a Gemini model as a fallback:

```text
google/gemini-3.5-flash-lite
```

## Why use Gemini?

It provides another independent AI provider.

This means that if the primary OpenRouter route is unavailable, OpenClaw can attempt Gemini.

The model was tested successfully in the laboratory.

---

# 6. OpenCode Zen

OpenCode Zen is another model-access provider used by the project.

The project authenticated OpenClaw with an OpenCode API key and tested several free models.

Examples tested successfully include:

```text
opencode/big-pickle
opencode/longcat-2.5-preview-free
opencode/mimo-v2.6-flash-free
opencode/nemotron-3.5-lightning-free
opencode/space-bunny-free
```

## Why use several OpenCode models?

They provide additional fallback choices.

However, free model availability and quotas are provider-controlled and may change.

The project therefore treats these models as **currently available free resources**, not permanent guarantees.

---

# 7. Current Model Routing

The current routing strategy is:

```text
Primary
    |
    v
openrouter/free
    |
    | unavailable / rate limited
    v
google/gemini-3.5-flash-lite
    |
    | unavailable / rate limited
    v
opencode/big-pickle
    |
    v
opencode/longcat-2.5-preview-free
    |
    v
opencode/mimo-v2.6-flash-free
    |
    v
opencode/nemotron-3.5-lightning-free
    |
    v
opencode/space-bunny-free
```

This configuration prioritizes **availability and cost** rather than assuming that the most powerful model is always the best choice.

---

# 8. Why We Did Not Immediately Purchase Credits

The project has access to paid credit options, but the design decision is:

> **Do not spend money when the current free resources are sufficient for the experiment.**

This provides several benefits.

### Financial

Students and researchers may not have access to paid APIs.

### Educational

It demonstrates how to work with quotas, fallback systems, and resource constraints.

### Engineering

It forces us to design for provider failure rather than assuming unlimited API availability.

### Reproducibility

A learner with no paid account may still be able to reproduce much of the laboratory.

---

# 9. Why Fallbacks Matter

Suppose the primary provider returns:

```text
HTTP 429
```

Instead of the entire AI environment becoming unavailable:

```text
OpenRouter
    |
   429
    |
    X
```

the system can try:

```text
OpenRouter
    |
   429
    |
    v
Gemini
    |
   429
    |
    v
OpenCode
```

This demonstrates an important engineering principle:

> **Design systems around failure, not only around the successful path.**

---

# 10. Free Cloud Resources

The laboratory uses Google Cloud infrastructure.

Cloud providers may offer:

- Free tiers
- Promotional credits
- Limited free resources

The project must distinguish these carefully.

For example:

```text
$300 promotional credit
```

should not be described as:

```text
$300 of permanent free hosting
```

The credit is a finite resource and can be consumed by billable infrastructure.

---

# 11. Cost-Conscious Cloud Design

The project therefore monitors:

- CPU allocation
- Memory allocation
- Disk usage
- Docker images
- Running containers
- Storage consumption
- Unused services
- AI API usage

The goal is to avoid paying for resources that are not required.

---

# 12. Open-Source Security Tools

The cybersecurity component intentionally relies heavily on open-source tools.

Examples include:

```text
Docker
Metasploit
Nmap
Wazuh
ELK components
WebGoat
OWASP Juice Shop
```

Open-source software can dramatically reduce the financial cost of building a cybersecurity practice environment.

However, open source does not automatically mean that the entire service is free under every possible deployment model. The project will document licensing and infrastructure costs where relevant.

---

# 13. Self-Hosting

Self-hosting means running software ourselves rather than paying a hosted provider to operate it for us.

Example:

```text
Hosted service
      |
      v
Provider infrastructure

versus

Self-hosted
      |
      v
Our Google Cloud VM
      |
      v
Docker / application
```

Self-hosting can reduce subscription costs but transfers responsibility for:

- Updates
- Security
- Backups
- Resource management
- Monitoring
- Availability

Therefore, self-hosting is not automatically easier; it is primarily a way to gain control and reduce recurring service costs.

---

# 14. Free Does Not Mean Unlimited

This is one of the most important principles in this project.

A free service can still have:

```text
Free
 |
 +-- Rate limit
 +-- Daily quota
 +-- Monthly quota
 +-- Model restrictions
 +-- Fair-use limits
 +-- Temporary availability
```

Therefore, the project records **availability** as well as price.

A model that costs $0 but is unavailable most of the time may be less useful than another free model with a smaller capability but better availability.

---

# 15. Availability Is a Design Requirement

The project prioritizes:

```text
Availability
     +
Capability
     +
Cost
```

rather than simply:

```text
Lowest price
```

For this reason, a free fallback chain is an important architectural component.

---

# 16. How We Record Free Resources

For each provider, we aim to document:

| Item | What we record |
|---|---|
| Provider | Who supplies the service |
| Model | Exact model identifier |
| Cost category | Free / free tier / credit / paid |
| Authentication | How the API is configured |
| Tested | Whether we actually tested it |
| Availability | Whether it was usable during testing |
| Limitations | Quotas/rate limits known at the time |
| Role | Primary or fallback |
| Date | When the information was verified |

This prevents the README from making vague claims such as "everything is free."

---

# 17. API Key Security

Free API access still requires responsible credential handling.

API keys must not be placed in:

```text
README.md
public GitHub repository
public GitLab repository
screenshots
chat logs
shell history
```

The repository uses `.gitignore` rules to prevent common secret files from being committed.

If a secret is accidentally exposed, it should be revoked/rotated rather than simply deleted from the visible file.

---

# 18. Subscription Policy

The project follows this policy:

### We do not purchase a subscription merely because a paid option exists.

Instead:

1. Test the free option.
2. Measure its availability.
3. Configure fallbacks.
4. Determine whether the limitation affects the project.
5. Look for another free/open-source option.
6. Consider payment only if the capability is genuinely necessary.

If a paid service is eventually introduced, the reason and cost should be documented.

---

# 19. Reproducibility for Students and Researchers

A major purpose of the free-first strategy is reproducibility.

A student should ideally be able to read the documentation and understand:

```text
What was used?
Why was it selected?
Where was the free access obtained?
What limitations existed?
How was it configured?
What did it cost?
```

This is more useful than simply saying:

> "We used a free AI API."

---

# 20. Cost Transparency

The project will maintain a clear distinction between:

```text
$0 actual payment
```

and:

```text
$0 currently paid because promotional credit was used
```

and:

```text
$0 within a provider's free quota
```

These are different situations.

---

# 21. Current Cost Philosophy

At the current stage:

```text
Paid AI subscriptions
        ↓
      Avoid

Free AI providers
        ↓
      Prefer

Open-source software
        ↓
      Prefer

Self-hosted components
        ↓
      Prefer

Cloud promotional credits
        ↓
      Use carefully

Paid services
        ↓
      Last resort
```

The goal is to keep the laboratory practical without making unrealistic claims that every component will remain free indefinitely.

---

# 22. Future Cost Tracking

As the project grows, we will record:

- Cloud machine type
- Storage
- Network-related charges where applicable
- AI provider usage
- Free quotas
- Promotional credits
- Paid services, if any
- Estimated monthly cost
- Ways to reduce cost

This will make the project useful as both a technical portfolio and a practical guide for learners working with limited budgets.

---

# 23. Important Disclaimer

Provider pricing, free tiers, quotas, model availability, and terms can change.

Therefore:

> **This document describes the project's tested configuration and cost strategy at the time of implementation. Always verify current provider terms before deploying a new environment or assuming a resource is free.**
