#!/usr/bin/env bash
# Execution VERIFY: PASS when ebt_core.settings ebt_core_secondary_color === '#ff8800'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("ebt_core.settings")->get("ebt_core_secondary_color");
  print (($v === "#ff8800") ? "PASS" : "FAIL") . " secondary_color=" . var_export($v, TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
