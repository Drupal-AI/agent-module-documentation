#!/usr/bin/env bash
# Execution VERIFY: PASS when Better Messages position is set to the top-right corner (tr).
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("better_messages.settings")->get("position");
  $ok = ($v === "tr");
  print ($ok ? "PASS" : "FAIL") . " position=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
