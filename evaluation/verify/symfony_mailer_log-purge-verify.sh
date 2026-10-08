#!/usr/bin/env bash
# Execution VERIFY: PASS when log entries expire after 30 days, 25 per cron run, i.e.
# log_expiry.max_age === "P30D" AND log_expiry.batch_size === 25. Prints PASS/FAIL.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("symfony_mailer_log.settings");
  $age = $c->get("log_expiry.max_age");
  $bs = $c->get("log_expiry.batch_size");
  $ok = ($age === "P30D" && ((int) $bs) === 25);
  print ($ok ? "PASS" : "FAIL") . " max_age=" . var_export($age, TRUE) . " batch_size=" . var_export($bs, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
