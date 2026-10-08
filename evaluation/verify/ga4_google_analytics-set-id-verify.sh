#!/usr/bin/env bash
# Execution VERIFY: PASS when ga4_google_analytics.config has measurement_id === "G-EXEC55TEST".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $id = \Drupal::config("ga4_google_analytics.config")->get("measurement_id");
  $ok = ($id === "G-EXEC55TEST");
  print ($ok ? "PASS" : "FAIL") . " measurement_id=" . var_export($id, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
