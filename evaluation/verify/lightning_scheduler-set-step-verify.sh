#!/usr/bin/env bash
# Execution VERIFY: PASS when lightning_scheduler.settings time_step === 300. Exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("lightning_scheduler.settings")->get("time_step");
  $ok = ((int) $v === 300);
  print ($ok ? "PASS" : "FAIL") . " time_step=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
