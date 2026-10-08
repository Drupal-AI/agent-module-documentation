#!/usr/bin/env bash
# Execution VERIFY: PASS when tx_hard2/inspect.html.twig exists and contains an argument-less
# breakpoint() call ({{ breakpoint() }}). exit 0 pass / 1 fail.
set -uo pipefail
F=/var/www/html/web/sites/default/files/tx_hard2/inspect.html.twig
if [ -f "$F" ] && grep -Eq 'breakpoint\(\s*\)' "$F"; then
  echo "PASS: $F contains breakpoint()"
  exit 0
fi
echo "FAIL: $F missing or has no argument-less breakpoint() call"
exit 1
