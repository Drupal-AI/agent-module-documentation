#!/usr/bin/env bash
# Execution VERIFY: PASS when currency_field_prefix == 'field_money_'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val=$(drush cget commerce_currency_resolver.settings currency_field_prefix --format=string 2>/dev/null)
if [ "$val" = "field_money_" ]; then echo "PASS currency_field_prefix=$val"; exit 0; fi
echo "FAIL currency_field_prefix=$val"; exit 1
