#!/usr/bin/env bash
# Execution VERIFY: PASS when /tmp/compiler_scss_eval_h1.css exists and contains 'padding: 20px'
# (proves the SCSS $p*2 arithmetic was actually compiled). exit 0 pass / 1 fail.
set -uo pipefail
F=/tmp/compiler_scss_eval_h1.css
if [ -f "$F" ] && grep -Eq 'padding:[[:space:]]*20px' "$F"; then
  echo "PASS $F contains padding: 20px"; exit 0
else
  echo "FAIL $F missing or does not contain 'padding: 20px'"; exit 1
fi
