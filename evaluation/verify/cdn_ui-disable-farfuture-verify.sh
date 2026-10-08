#!/usr/bin/env bash
# Execution VERIFY: PASS when cdn.settings:farfuture.status === FALSE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("cdn.settings")->get("farfuture.status"); print (($v===FALSE)?"PASS":"FAIL")." farfuture.status=".var_export($v,TRUE)."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
