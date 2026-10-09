#!/usr/bin/env bash
set -u

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LATEST="$(find "$BASE_DIR/evidence" -maxdepth 1 -type d -name 'runtime-*' | sort | tail -n 1)"

if [ -z "$LATEST" ]; then
  echo "No runtime evidence directory found."
  exit 1
fi

STAMP="$(basename "$LATEST")"
OUT="$BASE_DIR/evidence/reviewed-$STAMP"
mkdir -p "$OUT"

for f in "$LATEST"/*.txt; do
  cp "$f" "$OUT/"
done

# Remove the machine-specific evidence path from the summary.
sed -i -E 's#Evidence directory: .*#Evidence directory: [redacted for portfolio]#' "$OUT/00-summary.txt"

# Redact the Linux home path from OpenClaw process evidence.
sed -i -E 's#/home/[^ /]+#[redacted-home]#g' "$OUT/02-openclaw.txt"
# Redact Docker bridge addresses from OpenClaw evidence.
sed -i -E 's/172\.[0-9]+\.[0-9]+\.[0-9]+/[redacted-address]/g' "$OUT/02-openclaw.txt"

# Redact the published Open WebUI address while preserving the validation result.
sed -i -E 's/Published endpoint: [^[:space:]]+/Published endpoint: [redacted]/' "$OUT/04-labs.txt"

# Redact the published Open WebUI host address from Docker evidence.
sed -i -E 's/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:3000->[0-9]+/[redacted]:3000->8080/g' "$OUT/03-docker.txt"

# Replace the full project listener table with only ports needed to demonstrate the lab.
cat > "$OUT/07-listeners.txt" <<'EOF'
Cloud AI Cybersecurity Lab — Reviewed Project Listeners

This reviewed evidence intentionally omits unrelated listeners and host addresses.

Relevant listeners observed during validation:
- OpenClaw gateway: 18789 (localhost/container bridge)
- WebGoat: 8080 (localhost)
- Juice Shop: 3001 (localhost)
- VSFTPD lab: 2121 and 6200 (localhost)

See 02-openclaw.txt and 04-labs.txt for the corresponding validation results.
EOF

cat > "$OUT/08-review-status.txt" <<'EOF'
Cloud AI Cybersecurity Lab — Phase 5 Evidence Review

Evidence status:
- GCP host: PASS
- OpenClaw gateway: PASS
- Docker: PASS
- Juice Shop HTTP: PASS
- Open WebUI HTTP: PASS
- VSFTPD TCP connectivity: PASS
- Metasploit availability: PASS
- Model routing identifiers: PASS
- WebGoat: RUNNING / ROOT ENDPOINT VALIDATION PENDING

WebGoat returned HTTP 404 for the tested root path. This does not by itself prove that WebGoat is unavailable, so the portfolio evidence does not claim a WebGoat PASS.

The reviewed evidence is intended for repository publication. It excludes host addresses, unrelated listener details, and the Linux home path.

No exploit success is claimed.
EOF

echo "Reviewed evidence created:"
echo "$OUT"
echo "Review the files before committing."

