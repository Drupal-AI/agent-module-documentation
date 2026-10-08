#!/usr/bin/env bash
# Execution VERIFY: PASS when datatables.settings use_cdn is boolean TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("datatables.settings")->get("use_cdn");
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " use_cdn=" . var_export($v,true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
