#!/usr/bin/env bash
# Execution VERIFY: PASS when Better Messages autoclose is set to 5 (seconds). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("better_messages.settings")->get("autoclose");
  $ok = ((int) $v === 5);
  print ($ok ? "PASS" : "FAIL") . " autoclose=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
