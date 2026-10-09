#!/usr/bin/env bash
set -u

ROOT="${1:-$HOME/cloud-ai-cybersecurity-lab}"
STAMP="$(date -u +%Y%m%d-%H%M%S)"
OUT="$ROOT/evidence/phase6-gcp-$STAMP"

mkdir -p "$OUT"
exec > >(tee "$OUT/00-summary.txt") 2>&1

printf '%s\n' 'Cloud AI Cybersecurity Lab - Phase 6 GCP Validation'
printf 'Timestamp UTC: %s\n' "$STAMP"

printf '\n%s\n' '--- HOST ---'
uname -a
cat /etc/os-release | head -8
nproc
free -h
df -h /

printf '\n%s\n' '--- OPENCLAW ---'
command -v openclaw || true
openclaw --version 2>/dev/null || true
ps -ef | grep '[o]penclaw.*gateway' || true
ss -ltnp 2>/dev/null | grep ':18789' || true

printf '\n%s\n' '--- DOCKER ---'
docker version --format '{{.Server.Version}}' 2>/dev/null || true
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' 2>/dev/null || true

printf '\n%s\n' '--- LAB HTTP/TCP ---'

for x in \
  'JuiceShop|http://127.0.0.1:3001' \
  'WebGoat|http://127.0.0.1:8080'
do
    name="${x%%|*}"
    url="${x#*|}"
    code="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 10 "$url" 2>/dev/null || true)"
    printf '%s HTTP %s %s\n' "$name" "${code:-000}" "$url"
done

WEBUI_PORT="$(docker port open-webui 8080/tcp 2>/dev/null | head -1 || true)"
if [ -n "$WEBUI_PORT" ]; then
    WEBUI_HOST="${WEBUI_PORT%:*}"
    WEBUI_PUBLISHED="${WEBUI_PORT##*:}"
    WEBUI_CODE="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 10 "http://${WEBUI_HOST}:${WEBUI_PUBLISHED}" 2>/dev/null || true)"
    printf 'OpenWebUI HTTP %s published-port\n' "${WEBUI_CODE:-000}"
else
    printf '%s\n' 'OpenWebUI HTTP CHECK PENDING - published port not resolved'
fi

for p in 2121 6200
do
    if timeout 3 bash -c "</dev/tcp/127.0.0.1/$p" 2>/dev/null
    then
        printf 'VSFTPD TCP %s PASS\n' "$p"
    else
        printf 'VSFTPD TCP %s FAIL\n' "$p"
    fi
done

printf '\n%s\n' '--- METASPLOIT ---'
MSF="$(command -v msfconsole || true)"
printf 'Metasploit: %s\n' "${MSF:-NOT_FOUND}"
if [ -n "$MSF" ]; then
    msfconsole --version 2>/dev/null | head -2 || true
fi

printf '\n%s\n' '--- MODEL ROUTING ---'
grep -RhoE \
  'openrouter/free|google/gemini-[^[:space:]]+|opencode/[A-Za-z0-9._-]+' \
  "$ROOT/configs" "$ROOT/docs" 2>/dev/null |
  sort -u || true

printf '\n%s\n' '--- PROJECT FILES ---'
printf 'Phase 6 documentation files:\n'
find "$ROOT/docs" -maxdepth 1 -type f -iname '*phase6*' -printf '%f\n' 2>/dev/null | sort || true

printf '\n%s\n' '--- VALIDATION NOTES ---'
printf '%s\n' 'This validation is read-only.'
printf '%s\n' 'No exploit execution is performed.'
printf '%s\n' 'No exploit success is claimed.'
printf '%s\n' 'WebGoat root HTTP 404 does not by itself prove the application is unavailable.'
printf '%s\n' 'WebGoat status is RUNNING / ROOT ENDPOINT VALIDATION PENDING when the container is running.'

printf '\nPHASE6_GCP_OUTPUT=%s\n' "$OUT"
