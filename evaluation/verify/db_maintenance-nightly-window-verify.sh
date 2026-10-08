#!/usr/bin/env bash
# Execution VERIFY: PASS when use_time_interval===true and window is 02:00-03:00.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("db_maintenance.settings");
  $u = $c->get("use_time_interval"); $s = $c->get("time_interval_start"); $e = $c->get("time_interval_end");
  $ok = ($u === TRUE && $s === "02:00" && $e === "03:00");
  print ($ok ? "PASS" : "FAIL") . " use=" . var_export($u, TRUE) . " start=" . var_export($s, TRUE) . " end=" . var_export($e, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
