#!/usr/bin/env bash
# Execution VERIFY: PASS when public://um_projects.txt exists and lists the safe-to-delete project
# um_fixture (proving the agent used unused_modules to enumerate unused projects). exit 0/1.
set -uo pipefail
cd /var/www/html
F=web/sites/default/files/um_projects.txt
if [ ! -f "$F" ]; then echo "FAIL projects file missing"; exit 1; fi
if grep -q "um_fixture" "$F"; then echo "PASS um_projects.txt lists um_fixture"; exit 0; fi
echo "FAIL um_projects.txt does not mention um_fixture"; exit 1
