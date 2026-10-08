#!/usr/bin/env bash
# Execution VERIFY: PASS when the MaxMind license key config === 'VGEOIP_TEST_KEY'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("visitors_geoip.settings")->get("license");
  print (($v === "VGEOIP_TEST_KEY") ? "PASS" : "FAIL")." license=".var_export($v, TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
