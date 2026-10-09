#!/usr/bin/env bash
set -u

echo "=== Cloud AI Cybersecurity Lab Runtime Inventory ==="
echo

echo "[HOST]"
hostname
whoami
uname -a
echo

echo "[OS]"
cat /etc/os-release
echo

echo "[RESOURCES]"
nproc
free -h
df -h /
echo

echo "[OPENCLAW]"
if command -v openclaw >/dev/null 2>&1; then
    openclaw --version
else
    echo "openclaw command not found"
fi

systemctl is-active openclaw-gateway 2>/dev/null || true
echo

echo "[DOCKER]"
if command -v docker >/dev/null 2>&1; then
    docker --version
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"
else
    echo "docker command not found"
fi
echo

echo "[NETWORK LISTENERS]"
ss -lntp 2>/dev/null || ss -lnt
echo

echo "[METASPLOIT]"
if command -v msfconsole >/dev/null 2>&1; then
    which msfconsole
    msfconsole --version 2>/dev/null | head -n 1
else
    echo "msfconsole not found"
fi

echo
echo "Inventory complete."
