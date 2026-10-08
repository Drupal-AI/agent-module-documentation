#!/usr/bin/env bash
# Execution VERIFY: PASS when visitors.config items_per_page === 25.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (int) \Drupal::config("visitors.config")->get("items_per_page");
  print (($v === 25) ? "PASS" : "FAIL")." items_per_page=".$v."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
