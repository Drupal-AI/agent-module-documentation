#!/usr/bin/env bash
# Execution VERIFY: PASS when ape.settings exclusions contains the path /ape_exclude.
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("ape.settings")->get("exclusions");
  $ok = (strpos($v, "/ape_exclude") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " exclusions=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
