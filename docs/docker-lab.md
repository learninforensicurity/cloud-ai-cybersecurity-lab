# Docker Security Laboratory

## Purpose

The Docker laboratory provides intentionally vulnerable targets that can be used for cybersecurity education and authorized experimentation.

## Current Targets

### OWASP WebGoat

Purpose:

```text
web application security training
```

### OWASP Juice Shop

Purpose:

```text
modern web application security training
```

### VSFTPD 2.3.4

Purpose:

```text
controlled legacy service vulnerability study
```

## Container Discovery

Always discover current state rather than assuming container IDs or IP addresses:

```bash
docker ps
```

Detailed:

```bash
docker inspect <container-name>
```

## Port Discovery

Check host listeners:

```bash
ss -lntp
```

Check Docker mappings:

```bash
docker ps --format "table {{.Names}}\t{{.Ports}}"
```

## VSFTPD Deployment

The controlled VSFTPD service is:

```bash
docker rm -f vsftpd-lab

docker run -d \
  --name vsftpd-lab \
  -p 127.0.0.1:2121:21 \
  -p 127.0.0.1:6200:6200 \
  clintmint/vsftpd-2.3.4:1.0 \
  /bin/vsftpd /etc/vsftpd.conf
```

The localhost binding is intentional.

## Safety Boundary

Do not change:

```text
127.0.0.1
```

to:

```text
0.0.0.0
```

for a vulnerable service unless there is a documented, temporary, authorized reason and the network exposure has been reviewed.

## Connectivity

```bash
nc -v 127.0.0.1 6200
```

This tests TCP connectivity only.

## Security Testing

Security tools such as Metasploit may be used against the controlled targets.

The authorization boundary remains:

```text
Project-owned / explicitly authorized target
```

## Cleanup

Stop/remove a target when it is no longer needed:

```bash
docker stop <container>
```

or:

```bash
docker rm -f <container>
```

Do not remove containers blindly. Confirm the name first with `docker ps`.

## Principle

The vulnerable target is intentionally insecure.

The surrounding laboratory should be intentionally controlled.
