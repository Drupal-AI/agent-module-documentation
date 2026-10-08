#!/usr/bin/env bash
# Execution VERIFY: PASS when paragraph_blocks.settings:max_cardinality === 20. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("paragraph_blocks.settings")->get("max_cardinality"); print (((int)$v===20)?"PASS":"FAIL")." max_cardinality=".var_export($v,TRUE)."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
