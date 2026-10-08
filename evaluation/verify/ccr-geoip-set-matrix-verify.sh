#!/usr/bin/env bash
# Execution VERIFY: PASS when matrix.US == USD. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$m=\Drupal::config("commerce_currency_resolver_geoip.currency_mapping")->get("matrix")?:[]; print (isset($m["US"])&&$m["US"]==="USD")?"PASS":"FAIL"; print " US=".var_export($m["US"]??null,true);' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
