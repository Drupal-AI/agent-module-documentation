#!/usr/bin/env bash
# Execution VERIFY: PASS when the "default" (watchdog/dblog PSR logger) destination is active in
# config_log.settings.log_destination (key present and truthy). Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::config("config_log.settings")->get("log_destination") ?: [];
  $ok = !empty($d["default"]);
  print ($ok ? "PASS" : "FAIL") . " log_destination=" . json_encode($d) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
