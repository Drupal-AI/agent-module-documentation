#!/usr/bin/env bash
# Execution VERIFY: PASS when db_maintenance.settings all_tables===true AND cron_frequency===0.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("db_maintenance.settings");
  $all = $c->get("all_tables"); $freq = $c->get("cron_frequency");
  $ok = ($all === TRUE && (int) $freq === 0);
  print ($ok ? "PASS" : "FAIL") . " all_tables=" . var_export($all, TRUE) . " cron_frequency=" . var_export($freq, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
