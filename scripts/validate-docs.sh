#!/usr/bin/env bash
# Validate a generated module doc directory.
# Usage:  scripts/validate-docs.sh modules/token/1.17.x
set -uo pipefail

DIR="${1:?usage: validate-docs.sh modules/<name>/<version>}"
fail=0
err() { echo "FAIL: $1"; fail=1; }

# The JSON check needs php. Without this guard a missing interpreter makes `php -r` fail and the
# script reports "is not valid JSON" for every doc it is given — which is how it read on the host
# in wave 88, where php only exists inside the DDEV container. Fail on the real cause instead.
command -v php >/dev/null 2>&1 || {
  echo "FAIL: php not found — run this inside the container (ddev exec) or the JSON check cannot run" >&2
  exit 2
}

# data.json — must exist and be valid JSON
if [ ! -f "$DIR/data.json" ]; then err "$DIR/data.json missing"; else
  php -r 'json_decode(file_get_contents($argv[1])); exit(json_last_error() ? 1 : 0);' "$DIR/data.json" \
    || err "$DIR/data.json is not valid JSON"
fi

# usage.md — three '---'-separated blocks, 15–30 use-case bullets in the last block
if [ ! -f "$DIR/usage.md" ]; then err "$DIR/usage.md missing"; else
  seps=$(grep -cxE '\s*---\s*' "$DIR/usage.md")
  [ "$seps" -eq 2 ] || err "$DIR/usage.md has $seps '---' separators (want 2 → 3 blocks)"
  bullets=$(awk 'c==2 && /^[[:space:]]*[-*] /{n++} /^[[:space:]]*---[[:space:]]*$/{c++} END{print n+0}' "$DIR/usage.md")
  # Deprecated stubs (data.json "deprecated": true) are exempt from the 15–30 bullet rule.
  if grep -q '"deprecated"[[:space:]]*:[[:space:]]*true' "$DIR/data.json" 2>/dev/null; then
    [ "$bullets" -ge 1 ] || err "$DIR/usage.md (deprecated) needs at least 1 use-case bullet"
  else
    { [ "$bullets" -ge 15 ] && [ "$bullets" -le 30 ]; } || err "$DIR/usage.md has $bullets use-case bullets (want 15–30)"
  fi
fi

# agent/start.md — must exist and its relative links must resolve
if [ ! -f "$DIR/agent/start.md" ]; then err "$DIR/agent/start.md missing"; else
  # Check any relative .md links resolve. Zero links is fine (trivial modules).
  while read -r link; do
    [ -z "$link" ] && continue
    [ -f "$DIR/agent/$link" ] || err "$DIR/agent/start.md broken link -> $link"
  done < <(grep -oE '\]\(([^)]+\.md)\)' "$DIR/agent/start.md" | sed -E 's/\]\((.*)\)/\1/')
fi

[ "$fail" -eq 0 ] && echo "OK: $DIR" || exit 1
