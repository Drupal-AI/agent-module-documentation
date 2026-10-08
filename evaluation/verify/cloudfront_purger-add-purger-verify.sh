#!/usr/bin/env bash
# Execution VERIFY: PASS when purge.plugins purgers contains a purger with plugin_id 'cloudfront'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $purgers = \Drupal::config("purge.plugins")->get("purgers") ?: [];
  $found = FALSE;
  foreach ($purgers as $p) { if (($p["plugin_id"] ?? "") === "cloudfront") { $found = TRUE; } }
  print ($found ? "PASS" : "FAIL") . " purgers=" . count($purgers) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
