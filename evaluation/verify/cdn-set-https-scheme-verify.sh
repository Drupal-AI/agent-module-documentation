#!/usr/bin/env bash
# Execution VERIFY: PASS when cdn.settings:scheme === 'https://'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("cdn.settings")->get("scheme"); print (($v==="https://")?"PASS":"FAIL")." scheme=".var_export($v,TRUE)."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
