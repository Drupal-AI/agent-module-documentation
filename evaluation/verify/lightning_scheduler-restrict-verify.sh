#!/usr/bin/env bash
# Execution VERIFY: PASS when time_step === 3600 AND allow_past_dates is false. Exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("lightning_scheduler.settings");
  $step = $c->get("time_step");
  $past = $c->get("allow_past_dates");
  $ok = ((int) $step === 3600) && ($past == FALSE);
  print ($ok ? "PASS" : "FAIL") . " time_step=" . var_export($step, TRUE) . " allow_past_dates=" . var_export($past, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
