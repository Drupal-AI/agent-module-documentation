#!/usr/bin/env bash
# Execution VERIFY: PASS when the Markdown version of the aliased page is reachable at
# /mmp-md-node.md (HTTP 200, Content-Type text/markdown) — which only works when the
# markdownify_path submodule is enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
resp=$(curl -s -o /dev/null -w "%{http_code} %{content_type}" -H "Host: web" http://localhost/mmp-md-node.md 2>/dev/null)
echo "response: $resp"
code=$(echo "$resp" | awk '{print $1}')
if [ "$code" = "200" ] && echo "$resp" | grep -qi 'markdown'; then echo "PASS"; exit 0; else echo "FAIL"; exit 1; fi
