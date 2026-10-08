#!/usr/bin/env bash
# Execution VERIFY: PASS when admin_only === true.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("m4032404.settings")->get("admin_only");
  print (($v === TRUE) ? "PASS" : "FAIL") . " admin_only=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
