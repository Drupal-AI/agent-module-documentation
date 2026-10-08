#!/usr/bin/env bash
# Execution VERIFY: PASS when /tmp/cl_editorial_stable_ids.txt exists and lists the bundled
# stable component id cl_editorial:component-card (proving the agent used cl_editorial's
# NoThemeComponentManager with the 'stable' status filter). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
f=/tmp/cl_editorial_stable_ids.txt
if [ -f "$f" ] && grep -q 'cl_editorial:component-card' "$f"; then
  echo "PASS found cl_editorial:component-card in $f"
  exit 0
fi
echo "FAIL $f missing or does not list cl_editorial:component-card"
exit 1
