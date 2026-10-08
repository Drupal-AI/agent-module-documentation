#!/usr/bin/env bash
# Execution VERIFY: PASS when /tmp/dbug-eval-object.html contains a dbug OBJECT dump (the
# class="dBug_object" marker). exit 0 pass / 1 fail.
set -uo pipefail
f=/tmp/dbug-eval-object.html
if [ -f "$f" ] && grep -q 'dBug_object' "$f"; then
  echo "PASS: $f contains a dbug object dump (dBug_object)"
  exit 0
fi
echo "FAIL: $f missing or does not contain a dbug object dump (dBug_object)"
exit 1
