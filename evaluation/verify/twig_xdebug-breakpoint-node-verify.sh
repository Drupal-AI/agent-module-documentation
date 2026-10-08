#!/usr/bin/env bash
# Execution VERIFY: PASS when tx_hard1/debug.html.twig exists and sets a twig_xdebug
# breakpoint on the `node` variable. exit 0 pass / 1 fail.
set -uo pipefail
F=/var/www/html/web/sites/default/files/tx_hard1/debug.html.twig
if [ -f "$F" ] && grep -Eq 'breakpoint\(\s*node' "$F"; then
  echo "PASS: $F sets breakpoint(node...)"
  exit 0
fi
echo "FAIL: $F missing or has no breakpoint(node...) call"
exit 1
