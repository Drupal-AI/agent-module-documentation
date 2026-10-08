#!/usr/bin/env bash
# Execution VERIFY: PASS when currency_source == 'combo'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val=$(drush cget commerce_currency_resolver.settings currency_source --format=string 2>/dev/null)
if [ "$val" = "combo" ]; then echo "PASS currency_source=$val"; exit 0; fi
echo "FAIL currency_source=$val"; exit 1
