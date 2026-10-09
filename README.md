# Cloud AI Cybersecurity Lab

> **Integrating Cloud Computing + Artificial Intelligence + Cybersecurity into an accessible, beginner-friendly, free-first practical laboratory.**

---

## 🎯 Project Vision

The **Cloud AI Cybersecurity Lab** is a practical cybersecurity laboratory designed to explore how **Cloud Computing, Artificial Intelligence (AI), and Cybersecurity** can work together in one environment.

The long-term goal is to build a powerful learning and research platform that can be used by:

- Students learning cybersecurity
- Beginners learning Cloud, AI, Linux, Docker, and networking
- Cybersecurity researchers
- Security enthusiasts
- Developers interested in AI-powered security automation
- Anyone who wants to experiment with modern cybersecurity technologies without needing an expensive commercial laboratory

A major principle of this project is:

> **Build as much as possible using free, open-source, self-hosted, and free-tier resources before considering paid services.**

The project is therefore not only about building a technical system. It is also an experiment in answering an important question:

> **How capable can an AI-powered Cloud cybersecurity laboratory become while keeping the financial barrier as low as possible?**

---

# 📌 What Are We Building?

At a high level, this project combines:

```text
                    CLOUD
                      ☁️
                      │
                      ▼
              ┌───────────────┐
              │ Google Cloud  │
              │ Infrastructure│
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │    OpenClaw   │
              │   AI Agent    │
              └───────┬───────┘
                      │
          ┌───────────┼───────────┐
          │           │           │
          ▼           ▼           ▼
      OpenRouter    Gemini     OpenCode
        Free         Free        Free
          │           │           │
          └───────────┼───────────┘
                      │
                Model Fallback
                   Routing
                      │
                      ▼
                AI Assistance
                      │
                      ▼
              Native Tool Execution
                      │
          ┌───────────┴────────────┐
          │                        │
          ▼                        ▼
       Docker                  Security Tools
        Labs                   ├─ Metasploit
        ├─ VSFTPD              ├─ Nmap
        ├─ WebGoat             └─ Other tools
        └─ Juice Shop
```

The exact architecture will evolve as the project develops.

---

# ☁️ + 🤖 + 🔐 The Three Pillars

## ☁️ 1. Cloud Computing

The laboratory runs on cloud infrastructure rather than depending entirely on a local computer.

Our current environment uses **Google Cloud**.

### Why Cloud?

Cloud infrastructure allows a cybersecurity laboratory to:

- Run continuously
- Be accessed remotely
- Host Docker containers
- Run AI-agent infrastructure
- Experiment with Linux servers
- Separate laboratory workloads from the primary Windows workstation
- Learn practical cloud administration at the same time

### Concepts introduced

**Cloud VM**
A Virtual Machine provided by a cloud provider. It behaves like a remote computer running an operating system.

**Public IP**
An IP address through which a cloud resource can potentially be reached from the Internet.

**Private/Internal IP**
An address used inside a cloud network and generally not directly reachable from the public Internet.

**SSH**
Secure Shell. A protocol used to securely connect to and administer a remote Linux machine.

---

# 🤖 2. Artificial Intelligence

AI is not being used merely as a chatbot in this project.

The goal is to make AI an **active component of the cybersecurity laboratory**.

The AI agent can potentially:

- Understand natural-language requests
- Select appropriate tools
- Execute controlled commands
- Interact with Linux
- Work with security tools
- Assist with troubleshooting
- Analyze security information
- Assist with cybersecurity research
- Automate repetitive laboratory tasks

The project currently uses **OpenClaw** as the AI-agent/orchestration layer.

### What is an AI Agent?

A traditional chatbot generally responds with text.

An **AI agent** can go further. Depending on its configuration and permissions, it can:

1. Understand a task
2. Decide what action is required
3. Use available tools
4. Execute the action
5. Inspect the result
6. Continue the task based on that result

This project explores that capability in a controlled cybersecurity laboratory.

---

# 🔐 3. Cybersecurity

The cybersecurity component provides the practical environment in which the AI and cloud infrastructure can be tested.

The laboratory includes or is planned to include:

- Vulnerable Docker applications
- Security testing tools
- Metasploit
- Nmap
- SIEM-related projects
- Network-security laboratories
- Wazuh
- ELK
- pfSense
- Web security targets
- Linux security experiments
- Controlled exploitation exercises

Existing cybersecurity projects in the broader workspace include:

- Wazuh Docker HA Homelab
- ELK + pfSense Homelab
- Other security laboratories and experiments

The Cloud AI Cybersecurity Lab builds upon this broader learning environment.

---

# 🆓 Free-First Philosophy

One of the most important goals of this project is **accessibility**.

Cybersecurity laboratories can become expensive because they may require:

- Cloud servers
- AI APIs
- Commercial security platforms
- Commercial training environments
- Paid databases
- Specialized software

We therefore follow a **free-first strategy**.

## Our preferred order

```text
1. Free/open-source software
             ↓
2. Free API/model tier
             ↓
3. Self-hosted solution
             ↓
4. Free cloud tier or promotional credits
             ↓
5. Only if necessary → paid service
```

Paid services are not automatically rejected. However, before spending money, we try to determine whether the same requirement can be satisfied through a free or open-source alternative.

---

# 💰 How We Obtain Free AI Resources

The project experiments with multiple AI providers rather than depending on a single paid API.

Our current model strategy includes:

### OpenRouter

OpenRouter provides access to multiple AI models through an API interface.

The project uses the `openrouter/free` routing option as the primary model where available.

### Google Gemini

A Gemini free-access model is configured as a fallback.

Current tested model:

```text
google/gemini-3.5-flash-lite
```

### OpenCode Zen

OpenCode Zen provides a number of models that are available under free periods/tiers.

We have tested free models including:

```text
opencode/big-pickle
opencode/longcat-2.5-preview-free
opencode/mimo-v2.6-flash-free
opencode/nemotron-3.5-lightning-free
opencode/space-bunny-free
```

The exact availability of free models can change over time. Therefore, this project documents the provider and model availability at the time of configuration rather than assuming that a free tier will remain permanently available.

---

# 🔄 Why Use Multiple AI Providers?

AI providers have:

- Rate limits
- Usage quotas
- Temporary outages
- Model availability changes
- Different capabilities
- Different free-tier policies

Therefore, depending entirely on one provider can make an AI agent unreliable.

This project uses **fallback routing**.

For example:

```text
Primary
   │
   ▼
OpenRouter Free
   │
   ├── available ──► continue
   │
   └── unavailable
          │
          ▼
       Gemini
          │
          └── unavailable
                    │
                    ▼
              OpenCode Free
                    │
             ┌──────┼──────┐
             ▼      ▼      ▼
          Big     LongCat  MiMo
         Pickle
```

This allows the laboratory to continue functioning when a free provider temporarily reaches a limit.

---

# 📱 WhatsApp Integration

OpenClaw is connected to WhatsApp so that the AI agent can be accessed through a familiar messaging interface.

This provides a practical example of:

```text
WhatsApp
   ↓
OpenClaw
   ↓
AI Model
   ↓
Tools
   ↓
Linux / Docker / Security Lab
```

The project also uses model attribution in WhatsApp responses so that the user can see which backend model handled a request.

Example:

```text
[Model: google/gemini-3.5-flash-lite]
```

This is useful when testing fallback behavior and free-model availability.

---

# 🌐 Open WebUI

Open WebUI is also part of the laboratory environment.

It provides a browser-based interface for interacting with AI services.

The project treats Open WebUI and WhatsApp as different interfaces to the broader AI environment.

The exact role of Open WebUI may evolve as the project develops.

---

# 🐳 Docker

Docker is an important part of this laboratory.

## What is Docker?

Docker allows applications to run inside isolated environments called **containers**.

A container packages an application and the components required to run it.

Instead of installing every laboratory application directly onto the operating system, we can run many of them as containers.

### Why use Docker for cybersecurity?

Cybersecurity laboratories frequently require deliberately vulnerable applications.

Running these applications inside containers makes it easier to:

- Start a target
- Stop a target
- Remove a target
- Recreate a target
- Isolate applications
- Control network exposure
- Keep the host cleaner

---

# 🧪 Controlled Vulnerable Laboratories

The project uses deliberately vulnerable applications for educational security testing.

Examples include:

- VSFTPD 2.3.4
- WebGoat
- OWASP Juice Shop

These targets exist **only for controlled laboratory experimentation**.

## Example: VSFTPD Laboratory

VSFTPD 2.3.4 is a historically vulnerable FTP server version.

Our laboratory uses it as an intentionally vulnerable target.

The container is exposed only through localhost mappings during the controlled testing process.

Example:

```text
127.0.0.1:2121 → container port 21
127.0.0.1:6200 → container port 6200
```

This means the vulnerable service is not intentionally exposed as a public Internet target.

---

# 🛠️ Metasploit Integration

Metasploit is a widely used penetration-testing framework.

In this project, Metasploit is used only against **laboratory targets that we control**.

The project demonstrates how an AI agent can interact with existing cybersecurity tools.

For example:

```text
WhatsApp
    ↓
OpenClaw
    ↓
Native Exec Tool
    ↓
Linux Shell
    ↓
Metasploit
    ↓
Controlled Docker Target
```

This is an important experiment because it moves the AI from simply **describing cybersecurity commands** toward actually interacting with security tooling in a controlled environment.

---

# 🧠 Important Security Concept: Tool Execution

One of the major concepts explored by this project is **AI tool execution**.

An AI model normally generates text.

A tool-enabled AI agent can instead be given access to tools such as:

- Shell execution
- Process management
- File operations
- Network tools
- Security tools

For example:

```text
User:
"Check whether Metasploit is installed."

        ↓

AI Agent

        ↓

Exec Tool

        ↓

which msfconsole

        ↓

/usr/bin/msfconsole
```

This creates a major security consideration:

> **An AI agent with powerful tools is significantly more capable—and potentially more dangerous—than a chatbot that can only generate text.**

Therefore, permissions, isolation, network boundaries, credentials, and target selection are important parts of this project.

---

# 📚 Beginner-Friendly Concepts

This project intentionally explains technical concepts rather than assuming the reader already knows them.

## API

An **API (Application Programming Interface)** is a defined way for one software application to communicate with another.

For example:

```text
OpenClaw → AI Provider API → AI Model
```

---

## API Key

An API key is a credential used by a service to identify and authorize an application.

**API keys must never be committed to Git repositories.**

This project uses `.env` files, local configuration, and Git ignore rules where appropriate to prevent credentials from being published.

---

## LLM

**LLM** means Large Language Model.

An LLM is an AI model trained to understand and generate human-like text.

Examples of LLM providers/models used in this project include Gemini and models accessed through OpenRouter/OpenCode.

---

## Inference

**Inference** is the process of using an already-trained AI model to generate an answer from an input.

Training:

```text
Data → Model Training → Trained Model
```

Inference:

```text
User Request → Trained Model → Response
```

---

## Fallback

A fallback is an alternative service used when the preferred service cannot complete a request.

Example:

```text
OpenRouter Free
      ↓
     429
      ↓
Gemini
      ↓
     429
      ↓
OpenCode Free
```

---

## Rate Limit

A rate limit restricts how many requests or how much usage a service permits during a particular period.

HTTP `429` commonly indicates that a service is temporarily refusing requests because a usage limit has been reached.

---

## IP Address

An IP address identifies a device or network interface on an IP network.

Example:

```text
127.0.0.1
```

is the IPv4 loopback address.

It refers to the local machine itself.

---

## Port

A port identifies a network service endpoint.

For example:

```text
127.0.0.1:2121
```

means:

```text
IP address = 127.0.0.1
Port       = 2121
```

---

## TCP

TCP (Transmission Control Protocol) is a network protocol that provides reliable, connection-oriented communication.

Many common services such as HTTP, SSH, and FTP use TCP.

---

## Localhost

`localhost` normally refers to the current machine.

For IPv4:

```text
127.0.0.1
```

is the standard loopback address.

---

## Bind Shell

A bind shell is a shell that listens for an incoming connection on a network port.

Conceptually:

```text
Attacker/Tester ─────► Target:Port
                         │
                         ▼
                       Shell
```

A reverse shell works in the opposite direction:

```text
Target ─────► Tester
                 │
                 ▼
               Shell
```

These concepts are studied here only within controlled laboratory environments.

---

# 🏗️ Project Architecture

The architecture will evolve as additional components are added.

The current conceptual architecture is:

```text
                         INTERNET
                            │
                            │
                     ┌──────▼──────┐
                     │ Google Cloud│
                     │     VM      │
                     └──────┬──────┘
                            │
              ┌─────────────┴─────────────┐
              │                           │
              ▼                           ▼
        ┌───────────┐              ┌────────────┐
        │ OpenClaw  │              │   Docker   │
        │ AI Agent  │              │   Labs     │
        └─────┬─────┘              └─────┬──────┘
              │                          │
       ┌──────┼────────┐          ┌──────┼──────────┐
       ▼      ▼        ▼          ▼      ▼          ▼
 OpenRouter Gemini OpenCode     VSFTPD WebGoat Juice Shop
    Free      Free    Free
       │
       └──────────────┐
                      ▼
                AI Fallback
                  Routing
                      │
                      ▼
               Native Tools
                      │
              ┌───────┴───────┐
              ▼               ▼
           Linux          Security
           Shell           Tools
                           ├─ Nmap
                           └─ Metasploit
```

---

# 🔐 Security Philosophy

This project intentionally combines AI with powerful cybersecurity tools.

That creates significant security risks.

Therefore:

### 1. Vulnerable targets must be controlled

Deliberately vulnerable applications should not be exposed to the public Internet unnecessarily.

### 2. Credentials must remain private

The repository must never contain:

- API keys
- Passwords
- SSH private keys
- Cloud credentials
- WhatsApp authentication data
- OpenClaw authentication tokens
- Other secrets

### 3. AI tool access must be treated as privileged access

If an AI agent can execute shell commands, that capability should be considered similar to giving a user terminal access.

### 4. Testing must remain authorized

Security testing in this project is limited to systems and applications that we own or have explicit permission to test.

### 5. Documentation must distinguish demonstration from production

A laboratory configuration may intentionally be insecure because it is designed for education.

That does not mean the same configuration should be deployed on a production system.

---

# 🧑‍🎓 Who Is This Project For?

This project is intended to be useful for:

### Students

Students can use the documentation to understand concepts such as:

- Linux
- Cloud computing
- AI
- APIs
- Docker
- Networking
- Cybersecurity
- Penetration testing
- Security automation

### Researchers

Researchers can use the laboratory as a reproducible environment for experimenting with:

- AI agents
- Security automation
- Tool-using AI
- Multi-model routing
- Cloud-based cybersecurity
- Free/open-source security infrastructure

### Beginners

The documentation intentionally explains basic concepts before introducing more advanced ones.

### Recruiters and Interviewers

The repository demonstrates practical exposure to:

- Google Cloud
- Linux administration
- Git/GitHub/GitLab
- Docker
- AI APIs
- AI-agent architecture
- Model fallback strategies
- WhatsApp integration
- Security tooling
- Metasploit
- Vulnerable application laboratories
- Security architecture
- Documentation

---

# 🧪 Testing Philosophy

We do not consider a component complete simply because it was installed.

Whenever practical, the project follows:

```text
Install
   ↓
Configure
   ↓
Test
   ↓
Validate
   ↓
Document
```

For example:

```text
Install OpenCode provider
        ↓
Authenticate
        ↓
List models
        ↓
Test free models
        ↓
Add successful models to fallback
        ↓
Document configuration
```

This approach helps make the project reproducible.

---

# 📝 Documentation Philosophy

The documentation is deliberately beginner-friendly.

For important technologies and concepts, we try to answer:

### What is it?

A simple definition.

### Why are we using it?

The reason it exists in this project.

### How does it work?

A simplified technical explanation.

### How did we configure it?

The practical implementation.

### How did we test it?

The validation procedure.

### What did we learn?

The practical lesson.

This makes the repository both a **portfolio project and a personal learning reference**.

---

# 💵 Cost Philosophy

The project is designed around the idea of **minimum practical cost**.

We distinguish between:

### Free

A resource can be used without payment under the provider's current terms.

### Free Tier

A service provides a limited amount of usage at no cost.

### Promotional Credit

A provider gives temporary credits that can be consumed by otherwise billable infrastructure.

### Paid

Usage requires actual payment.

These categories should never be mixed together in the documentation.

For example, cloud promotional credits should not be described as permanent free cloud hosting.

---

# 📊 Cost Tracking

As the project grows, we will document:

- Cloud resources
- AI providers
- API usage
- Free quotas
- Promotional credits
- Potential paid components
- Approximate monthly cost
- Ways to reduce cost

The goal is to make the project reproducible by someone with limited financial resources.

---

# 🗂️ Repository Structure

Current structure:

```text
cloud-ai-cybersecurity-lab/
│
├── README.md
│
├── .gitignore
│
├── architecture/
│
├── configs/
│
├── docs/
│   ├── architecture.md
│   ├── concepts.md
│   ├── deployment.md
│   ├── free-resources.md
│   ├── security.md
│   └── testing.md
│
├── evidence/
│
├── labs/
│
└── scripts/
```

The repository will grow as the laboratory develops.

---

# 🔬 Current Laboratory Components

At the current stage, the environment includes or has been tested with:

| Component | Purpose |
|---|---|
| Google Cloud VM | Cloud infrastructure |
| Debian Linux | Server operating system |
| OpenClaw | AI agent/orchestration |
| OpenRouter | AI model access |
| Google Gemini | AI fallback |
| OpenCode Zen | Additional free AI models |
| WhatsApp | Remote AI-agent interface |
| Open WebUI | Browser-based AI interface |
| Docker | Containerized laboratories |
| VSFTPD 2.3.4 | Deliberately vulnerable FTP target |
| WebGoat | Web-security training target |
| OWASP Juice Shop | Web-security training target |
| Metasploit | Controlled penetration testing |
| Nmap | Network/security reconnaissance |

Availability and configuration of external services may change over time.

---

# 🚧 Project Status

This project is actively under development.

### Completed / Validated

- [x] Google Cloud Linux environment
- [x] Docker environment
- [x] OpenClaw installation
- [x] OpenRouter integration
- [x] Gemini integration
- [x] OpenCode Zen integration
- [x] Multiple free-model tests
- [x] AI fallback configuration
- [x] WhatsApp integration
- [x] Model attribution in WhatsApp responses
- [x] Native OpenClaw command execution
- [x] Metasploit availability
- [x] Controlled VSFTPD 2.3.4 laboratory
- [x] Controlled localhost network exposure
- [x] Initial AI-to-security-tool experimentation

### In Progress

- [ ] Complete project documentation
- [ ] Architecture diagrams
- [ ] Automated deployment scripts
- [ ] Reproducible laboratory setup
- [ ] Security hardening documentation
- [ ] Cost monitoring
- [ ] AI-assisted cybersecurity workflows
- [ ] Integration with existing Wazuh/ELK security projects

### Future Goals

- [ ] AI-assisted SIEM analysis
- [ ] AI-assisted incident investigation
- [ ] Security alert triage
- [ ] Automated laboratory provisioning
- [ ] Additional cybersecurity targets
- [ ] More open/free AI models
- [ ] Improved model-selection logic
- [ ] Security-focused agent workflows
- [ ] Integration with Wazuh
- [ ] Integration with ELK/pfSense
- [ ] Reproducible deployment documentation
- [ ] Educational exercises for students

---

# 🔗 Relationship With Other Cybersecurity Projects

The Cloud AI Cybersecurity Lab is part of a broader cybersecurity learning environment.

Related projects include:

```text
Cybersecurity Portfolio
│
├── Wazuh Docker HA Homelab
│       └── SIEM / Security Monitoring
│
├── ELK + pfSense Homelab
│       └── Network Security / Log Analysis
│
└── Cloud AI Cybersecurity Lab
        ├── Cloud
        ├── AI
        ├── Automation
        └── Security Testing
```

The long-term objective is to connect these areas rather than treat them as completely isolated projects.

---

# 🌐 Git, GitHub and GitLab

The project is developed using Git.

Git provides **version control**, meaning it records changes to the project over time.

This allows us to:

- Track development
- Revert mistakes
- Document milestones
- Collaborate
- Maintain a reproducible history

The project can be maintained through remote repositories such as GitHub and GitLab.

The local Windows development environment is used for project documentation and Git management, while the Google Cloud machine provides the runtime laboratory environment.

---

# 🖥️ Development Workflow

The intended workflow is:

```text
Windows Host
     │
     ▼
VS Code
     │
     ▼
Git
     │
 ┌───┴────┐
 ▼        ▼
GitHub   GitLab
     │
     ▼
Cloud Laboratory
     │
     ▼
Google Cloud VM
```

This separation keeps development, documentation, and runtime infrastructure organized.

---

# 📸 Evidence and Reproducibility

The `evidence/` directory may contain carefully selected screenshots or other evidence demonstrating successful configuration and testing.

Sensitive information must be removed before anything is committed.

Never upload screenshots containing:

- API keys
- passwords
- access tokens
- private SSH keys
- session tokens
- QR codes used for authentication
- other confidential information

---

# ⚖️ Responsible Use

This laboratory is intended for **education, research, and authorized security testing**.

Cybersecurity tools can be used for legitimate defensive research and also for unauthorized attacks.

The presence of a tool in this repository does not authorize its use against systems belonging to others.

Always obtain appropriate authorization before testing a system.

The deliberately vulnerable applications in this project exist specifically so that security techniques can be practiced in a controlled environment.

---

# 📖 Learning Approach

This project follows a simple philosophy:

> **Understand → Build → Test → Break → Fix → Document**

We do not want to simply copy commands from tutorials.

For each major component, we want to understand:

```text
What?
Why?
How?
Test?
Result?
Lesson?
```

This makes the laboratory useful not only as a technical demonstration but also as a long-term cybersecurity learning environment.

---

# 🗺️ Roadmap

## Phase 1 — Foundation

- Cloud VM
- Linux
- Docker
- Git
- OpenClaw
- Basic AI provider integration

## Phase 2 — Free AI Infrastructure

- OpenRouter free models
- Gemini free access
- OpenCode free models
- Model fallback
- Availability testing
- Cost-conscious model selection

## Phase 3 — AI Interfaces

- WhatsApp
- Open WebUI
- Model attribution
- Remote interaction

## Phase 4 — Security Tool Integration

- Linux tools
- Nmap
- Metasploit
- Docker security targets
- Controlled command execution

## Phase 5 — Security Monitoring

- Wazuh
- ELK
- pfSense
- Security logs
- AI-assisted analysis

## Phase 6 — AI Cybersecurity Automation

- Alert analysis
- Investigation assistance
- Security workflow automation
- Controlled response actions
- AI-assisted incident investigation

## Phase 7 — Educational Platform

The long-term objective is to make the environment sufficiently documented and reproducible that another learner can follow the project and build a similar laboratory.

---

# ⭐ Final Goal

The ultimate goal is not simply to create another AI chatbot or another cybersecurity lab.

It is to explore the combination of:

```text
        ☁️ CLOUD
           +
        🤖 AI
           +
       🔐 CYBERSECURITY
           +
       🆓 ACCESSIBILITY
           =
   PRACTICAL LEARNING LAB
```

We want to demonstrate that modern cybersecurity learning does not necessarily require a large commercial budget.

By combining:

- Cloud infrastructure
- Free/free-tier AI resources
- Open-source software
- Docker
- Cybersecurity tools
- Deliberately vulnerable applications
- Automation
- Careful documentation

we aim to build a practical environment that students, researchers, and cybersecurity learners can understand, reproduce, experiment with, and improve.

> **Build it. Understand it. Test it. Document it. Share what we learn.**

---

## 📌 Disclaimer

This repository is an educational cybersecurity laboratory.

All offensive-security demonstrations are intended for systems that are owned by the project author or for which explicit authorization has been obtained.

Do not use the techniques, tools, or procedures documented here against systems without authorization.

---

## 📄 License

License information will be added once the project's redistribution requirements and included components have been reviewed.

---

**Project:** Cloud AI Cybersecurity Lab
**Primary themes:** Cloud Computing · Artificial Intelligence · Cybersecurity · Automation · Open Source · Free-First Learning
