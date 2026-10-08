#!/usr/bin/env bash
# Execution VERIFY: PASS when config_merge_filter_eval_update holds the filter's merged output for
# incoming {n:2} on an uncustomized item — update adopted so n === 2. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("config_merge_filter_eval_update");
  $n = is_array($v) ? ($v["n"] ?? NULL) : NULL;
  print (($n === 2) ? "PASS" : "FAIL") . " n=" . var_export($n, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
