#!/usr/bin/env bash
# Execution VERIFY: PASS when languageicons.settings placement === "replace".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val=$(drush config:get languageicons.settings placement --format=string 2>/dev/null | tr -d '[:space:]')
if [ "$val" = "replace" ]; then echo "PASS placement=$val"; exit 0; else echo "FAIL placement=$val"; exit 1; fi
