#!/usr/bin/env bash
# Execution VERIFY: PASS when better_passwords.settings auto_generate === 2 (Required). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("better_passwords.settings")->get("auto_generate");
  $ok = ((int) $v === 2);
  print ($ok ? "PASS" : "FAIL") . " auto_generate=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
