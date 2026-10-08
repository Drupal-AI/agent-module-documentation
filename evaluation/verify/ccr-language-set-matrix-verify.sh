#!/usr/bin/env bash
# Execution VERIFY: PASS when matrix.en == USD. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$m=\Drupal::config("commerce_currency_resolver_language.currency_mapping")->get("matrix")?:[]; print (isset($m["en"])&&$m["en"]==="USD")?"PASS":"FAIL"; print " en=".var_export($m["en"]??null,true);' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
