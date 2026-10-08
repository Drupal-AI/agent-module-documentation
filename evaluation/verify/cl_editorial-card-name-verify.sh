#!/usr/bin/env bash
# Execution VERIFY: PASS when /tmp/cl_editorial_card_name.txt contains the bundled component's
# human-readable name "Component Card" (from cl_editorial:component-card metadata). Exit 0/1.
set -uo pipefail
f=/tmp/cl_editorial_card_name.txt
if [ -f "$f" ] && grep -qi 'Component Card' "$f"; then
  echo "PASS found 'Component Card' in $f"
  exit 0
fi
echo "FAIL $f missing or does not contain 'Component Card'"
exit 1
