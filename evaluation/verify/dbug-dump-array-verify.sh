#!/usr/bin/env bash
# Execution VERIFY: PASS when /tmp/dbug-eval-array.html contains a dbug ARRAY dump (the
# class="dBug_array" table marker) and the expected keys. exit 0 pass / 1 fail.
set -uo pipefail
f=/tmp/dbug-eval-array.html
if [ -f "$f" ] && grep -q 'dBug_array' "$f" && grep -q 'apple' "$f" && grep -q 'banana' "$f"; then
  echo "PASS: $f contains a dbug array dump with keys apple/banana"
  exit 0
fi
echo "FAIL: $f missing or does not contain a dbug array dump (dBug_array + apple + banana)"
exit 1
