#!/usr/bin/env bash
# Execution VERIFY: PASS when google_map_field.settings google_map_field_apikey === expected.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("google_map_field.settings")->get("google_map_field_apikey");
  $ok = ($v === "AIzaGmfTaskKey123");
  print ($ok ? "PASS" : "FAIL") . " apikey=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
