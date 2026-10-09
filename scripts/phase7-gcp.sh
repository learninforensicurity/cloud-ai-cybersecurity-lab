#!/usr/bin/env bash
set -u
ROOT="${1:-$HOME/cloud-ai-cybersecurity-lab}"
STAMP="$(date -u +%Y%m%d-%H%M%S)"
OUT="$ROOT/evidence/phase7-gcp-$STAMP"
mkdir -p "$OUT"
exec > >(tee "$OUT/00-summary.txt") 2>&1
printf '%s\n' 'Cloud AI Cybersecurity Lab - Phase 7 GCP Portfolio Validation'
printf 'Timestamp UTC: %s\n' "$STAMP"
printf '\n%s\n' '--- GIT ---'
git -C "$ROOT" status --short --branch
git -C "$ROOT" log -1 --oneline
git -C "$ROOT" remote -v
printf '\n%s\n' '--- HOST ---'
uname -a
nproc
free -h
df -h /
printf '\n%s\n' '--- OPENCLAW ---'
command -v openclaw || true
openclaw --version 2>/dev/null || true
ps -ef | grep '[o]penclaw.*gateway' || true
printf '\n%s\n' '--- DOCKER ---'
docker version --format '{{.Server.Version}}' 2>/dev/null || true
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' 2>/dev/null || true
printf '\n%s\n' '--- SECURITY ARTIFACT CHECK ---'
find "$ROOT" -path "$ROOT/.git" -prune -o -type f \( -name '.env' -o -name '*.pem' -o -name '*.key' \) -print 2>/dev/null || true
printf '\n%s\n' '--- RESULT ---'
printf '%s\n' 'Portfolio/reproducibility validation is read-only.'
printf '%s\n' 'No exploit execution is performed.'
printf 'PHASE7_GCP_OUTPUT=%s\n' "$OUT"
