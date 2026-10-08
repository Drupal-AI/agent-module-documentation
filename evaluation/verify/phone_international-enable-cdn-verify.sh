#!/usr/bin/env bash
# Execution VERIFY: PASS when phone_international.settings.cdn === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("phone_international.settings")->get("cdn");
  print (($v === TRUE) ? "PASS" : "FAIL") . " cdn=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
