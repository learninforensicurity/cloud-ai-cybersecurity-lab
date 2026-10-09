#!/usr/bin/env bash
set -u

echo "=== Cloud AI Cybersecurity Lab Health Check ==="
echo

echo "[1] Host"
hostname
whoami
printf "Kernel: "
uname -r
echo

echo "[2] Resources"
printf "CPU: "
nproc
free -h
df -h /
echo

echo "[3] Docker"
if command -v docker >/dev/null 2>&1; then
    docker --version
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"
else
    echo "Docker: NOT INSTALLED"
fi
echo

echo "[4] OpenClaw gateway service"
if command -v systemctl >/dev/null 2>&1; then
    systemctl is-active --quiet openclaw-gateway \
        && echo "openclaw-gateway: ACTIVE" \
        || echo "openclaw-gateway: NOT ACTIVE"
else
    echo "systemctl unavailable"
fi
echo

echo "[5] OpenClaw port"
ss -lnt 2>/dev/null | grep -E ':18789[[:space:]]' \
    && echo "Gateway listener detected" \
    || echo "Gateway listener not detected"
echo

echo "[6] Laboratory listeners"
ss -lnt 2>/dev/null | grep -E ':(2121|6200|3000)[[:space:]]' \
    || echo "No configured lab listeners detected"
echo

echo "[7] Metasploit"
if command -v msfconsole >/dev/null 2>&1; then
    echo "msfconsole: $(command -v msfconsole)"
    msfconsole --version 2>/dev/null | head -n 1
else
    echo "msfconsole: NOT FOUND"
fi

echo
echo "Health check complete."
