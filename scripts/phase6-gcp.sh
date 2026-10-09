#!/usr/bin/env bash
set -u
ROOT="${1:-$HOME/cloud-ai-cybersecurity-lab}"
STAMP="$(date -u +%Y%m%d-%H%M%S)"
OUT="$ROOT/evidence/phase6-gcp-$STAMP"
mkdir -p "$OUT"
exec > >(tee "$OUT/00-summary.txt") 2>&1
printf 'Cloud AI Cybersecurity Lab - Phase 6 GCP Validation\nTimestamp UTC: %s\n' "$STAMP"
printf '\n--- HOST ---\n'; uname -a; cat /etc/os-release | head -8; nproc; free -h; df -h /
printf '\n--- OPENCLAW ---\n'; command -v openclaw || true; openclaw --version 2>/dev/null || true; ps -ef | grep '[o]penclaw.*gateway' || true; ss -ltnp 2>/dev/null | grep ':18789' || true
printf '\n--- DOCKER ---\n'; docker version --format '{{.Server.Version}}' 2>/dev/null || true; docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' 2>/dev/null || true
printf '\n--- LAB HTTP/TCP ---\n'; for x in 'JuiceShop|http://127.0.0.1:3001' 'OpenWebUI|http://127.0.0.1:3000' 'WebGoat|http://127.0.0.1:8080'; do name="${x%%|*}"; url="${x#*|}"; code=$(curl -sS -o /dev/null -w '%{http_code}' --max-time 10 "$url" 2>/dev/null || echo 000); printf '%s HTTP %s %s\n' "$name" "$code" "$url"; done
for p in 2121 6200; do if timeout 3 bash -c "</dev/tcp/127.0.0.1/$p" 2>/dev/null; then echo "VSFTPD TCP $p PASS"; else echo "VSFTPD TCP $p FAIL"; fi; done
printf '\n--- METASPLOIT ---\n'; command -v msfconsole || true; msfconsole --version 2>/dev/null | head -2 || true
printf '\n--- MODEL ROUTING ---\n'; grep -RhoE 'openrouter/free|google/gemini-[^[:space:]"'"']+|opencode/[A-Za-z0-9._-]+' "$ROOT/configs" "$ROOT/docs" 2>/dev/null | sort -u || true
printf '\nPhase 6 GCP validation is read-only. No exploit success is claimed.\n'
printf 'PHASE6_GCP_OUTPUT=%s\n' "$OUT"
