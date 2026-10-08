#!/usr/bin/env bash
# Execution VERIFY: PASS when allowed_hosts contains https://data.mditask.gov. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $h = \Drupal::config("media_tyler_data_insights.settings")->get("allowed_hosts") ?: [];
  $ok = in_array("https://data.mditask.gov", $h, TRUE);
  print ($ok ? "PASS" : "FAIL") . " allowed_hosts=" . json_encode($h) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
