#!/usr/bin/env bash
# Execution VERIFY: PASS when /tmp/compiler_scss_eval_h2.css exists, contains the compiled nested
# selector '.a .b' and 'color: red' (proves SCSS nesting was compiled). exit 0 pass / 1 fail.
set -uo pipefail
F=/tmp/compiler_scss_eval_h2.css
if [ -f "$F" ] && grep -q '\.a \.b' "$F" && grep -Eq 'color:[[:space:]]*red' "$F"; then
  echo "PASS $F contains '.a .b' and color: red"; exit 0
else
  echo "FAIL $F missing or lacks compiled nesting"; exit 1
fi
