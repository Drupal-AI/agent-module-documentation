#!/usr/bin/env bash
# Execution VERIFY: PASS when languageicons.settings size === "32x24".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val=$(drush config:get languageicons.settings size --format=string 2>/dev/null | tr -d '[:space:]')
if [ "$val" = "32x24" ]; then echo "PASS size=$val"; exit 0; else echo "FAIL size=$val"; exit 1; fi
