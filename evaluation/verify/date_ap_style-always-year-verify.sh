#!/usr/bin/env bash
# Execution VERIFY: PASS when date_ap_style.settings always_display_year === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("date_ap_style.settings")->get("always_display_year");
  print (($v===TRUE) ? "PASS" : "FAIL") . " always_display_year=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
