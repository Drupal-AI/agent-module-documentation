#!/usr/bin/env bash
# Execution VERIFY: PASS when public://um_report.txt exists and lists the unused module um_fixture
# (proving the agent used unused_modules to enumerate disabled modules). exit 0/1.
set -uo pipefail
cd /var/www/html
F=web/sites/default/files/um_report.txt
if [ ! -f "$F" ]; then echo "FAIL report file missing"; exit 1; fi
if grep -q "um_fixture" "$F"; then echo "PASS um_report.txt lists um_fixture"; exit 0; fi
echo "FAIL um_report.txt does not mention um_fixture"; exit 1
