# Concepts and Definitions

This document explains the important concepts used by the Cloud AI Cybersecurity Lab. It is intentionally beginner-friendly and explains what a technology is, why we use it, and how it fits into the project.

## Cloud Computing
Cloud computing means using computing resources such as servers, storage, and networking through a cloud provider. Our laboratory uses Google Cloud.

**Cloud VM:** a virtual computer running on cloud infrastructure.

## Linux
Linux is an operating system widely used for servers and cybersecurity work. Our cloud laboratory uses Debian Linux.

## Terminal and Shell
A terminal provides a text interface to a computer. A shell interprets commands entered into the terminal. For example, `whoami` displays the current user.

## IP Address
An IP address identifies a network interface. A private address is normally used inside a network; a public address can potentially be reached from the Internet depending on firewall rules.

## Localhost
`127.0.0.1` is the IPv4 loopback address. Traffic sent there stays on the same machine. We use localhost bindings for laboratory services where remote access is unnecessary.

## Port
A port identifies a network service endpoint. `127.0.0.1:2121` means address `127.0.0.1`, port `2121`.

## TCP
TCP is a connection-oriented network protocol used by many common services.

## API
An API (Application Programming Interface) defines how software communicates with another service. Example: OpenClaw -> AI provider API -> model response.

## API Key
An API key is a credential used to identify or authorize an API client. API keys are secrets and must never be committed to a public repository.

## Artificial Intelligence
AI is a broad field concerned with systems capable of tasks involving aspects of human intelligence. In this project AI is used for interaction, reasoning assistance, analysis, tool use, and automation.

## LLM
LLM means Large Language Model. It is an AI model trained to understand and generate language. This project accesses models through providers such as OpenRouter, Google Gemini, and OpenCode Zen.

## Inference
Inference is the process of using a trained model to generate an output from an input.

## AI Agent
An AI agent can use tools and take actions in addition to generating text. OpenClaw is the agent/orchestration layer in this project.

## Tool Execution
Tool execution allows an agent to interact with capabilities such as shell commands, files, network utilities, and security tools. Giving an AI agent shell access gives it significant privileges and therefore requires careful controls.

## Model Provider
A model provider is a service through which AI models can be accessed. This project uses multiple providers to reduce dependence on one service.

## Fallback
A fallback is an alternative model/provider used when the preferred one is unavailable, rate-limited, or otherwise unable to complete a request.

## Rate Limit
A rate limit restricts usage during a period. HTTP 429 commonly indicates that a service has refused a request because of rate or quota limits.

## Free Tier
A free tier is limited usage provided without payment. Free tiers can have quotas, rate limits, model restrictions, or changing availability.

## Promotional Credit
Promotional cloud credit is temporary credit that can be consumed by billable resources. It is different from permanent free hosting.

## Docker
Docker packages and runs applications in containers. Containers make it easier to isolate, recreate, and remove cybersecurity laboratory applications.

## Docker Image
A Docker image is a packaged template used to create containers.

## Docker Container
A container is a running instance created from an image.

## Port Mapping
Docker can map a host port to a container port. Example: `127.0.0.1:2121 -> container:21`.

## Vulnerable Laboratory Target
A deliberately vulnerable application is intentionally used for authorized security training. Examples in this project include VSFTPD 2.3.4, WebGoat, and OWASP Juice Shop.

## Vulnerability
A vulnerability is a weakness that can cause unintended behavior or security impact.

## Exploit
An exploit is a technique or code that takes advantage of a vulnerability.

## Payload
A payload is the part of an exploitation workflow that performs an action after exploitation succeeds, such as executing a command or creating a shell.

## Bind Shell
A bind shell listens for an incoming connection on a target port.

## Reverse Shell
A reverse shell causes the target to initiate a connection back to the testing system.

## Metasploit
Metasploit is a penetration-testing framework containing exploit, payload, auxiliary, and session functionality. In this project it is used only against controlled laboratory targets.

## SIEM
SIEM means Security Information and Event Management. A SIEM collects and analyzes security events. The broader CyberLab workspace includes Wazuh and ELK/pfSense projects.

## Git
Git is a distributed version-control system that records changes to a project over time.

## Repository
A Git repository contains project files and their version history.

## Commit
A commit is a recorded snapshot of changes. The first project commit is `477fef1`, titled `Initial Cloud AI Cybersecurity Lab documentation`.

## GitHub and GitLab
GitHub and GitLab host Git repositories and provide collaboration/development features. This project maintains the same repository on both platforms.

## Remote
A Git remote is a named reference to another copy of a repository. This project uses `github` and `gitlab` remotes.

## Free-First Architecture
The project follows this preference: open source -> free API/model tier -> self-hosted solution -> free cloud tier/credit -> paid option only when necessary.

The goal is not to claim that every component will always be free. The goal is to minimize financial barriers and document the actual cost and limitations honestly.

## Key Principle
The goal is to understand how the concepts connect:

Cloud -> Linux -> Docker -> Cybersecurity Labs -> Security Tools
                     ^
                     |
                 AI Agent
                     ^
                     |
              AI Models/APIs
                     ^
                     |
             WhatsApp/Web UI
