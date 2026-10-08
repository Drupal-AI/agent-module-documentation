#!/usr/bin/env bash
# Execution VERIFY: PASS when Drupal state geophp_eval_area holds the area of
# POLYGON((0 0,0 10,10 10,10 0,0 0)), i.e. 100. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("geophp_eval_area");
  $ok = ($v !== NULL && is_numeric($v) && abs((float) $v - 100.0) < 0.001);
  print ($ok ? "PASS" : "FAIL") . " geophp_eval_area=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
