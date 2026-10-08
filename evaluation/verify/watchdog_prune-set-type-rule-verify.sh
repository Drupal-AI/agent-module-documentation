#!/usr/bin/env bash
# Execution VERIFY: PASS when watchdog_prune_age_type contains a php rule with a 1-month age.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("watchdog_prune.settings")->get("watchdog_prune_age_type");
  $ok = is_string($v) && preg_match("/php\s*\|/i", $v) && preg_match("/1\s*month/i", $v);
  print ($ok ? "PASS" : "FAIL") . " watchdog_prune_age_type=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
