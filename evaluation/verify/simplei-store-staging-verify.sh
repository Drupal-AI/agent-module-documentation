#!/usr/bin/env bash
# Execution VERIFY: PASS when State key simplei_eval_bg holds the background color the simplei
# IndicatorParser assigns to '@staging' (GoldenRod). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::state()->get("simplei_eval_bg", "");
  $ok = ($v === "GoldenRod");
  print ($ok ? "PASS" : "FAIL") . " simplei_eval_bg=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
