#!/usr/bin/env bash
# Execution VERIFY: PASS when watchdog_prune.settings:watchdog_prune_age is a 3-month age.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("watchdog_prune.settings")->get("watchdog_prune_age");
  $ok = is_string($v) && preg_match("/3\s*month/i", $v);
  print ($ok ? "PASS" : "FAIL") . " watchdog_prune_age=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
