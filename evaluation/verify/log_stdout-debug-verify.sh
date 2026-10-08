#!/usr/bin/env bash
# Execution VERIFY: PASS when log_stdout.settings severity_level == 7 (Debug).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("log_stdout.settings")->get("severity_level");
  $ok = ((int) $v === 7);
  print ($ok ? "PASS" : "FAIL") . " severity_level=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
