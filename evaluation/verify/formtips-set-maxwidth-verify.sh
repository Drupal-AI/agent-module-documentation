#!/usr/bin/env bash
# Execution VERIFY: PASS when formtips.settings:formtips_max_width === '640px'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("formtips.settings")->get("formtips_max_width");
  print (($v === "640px") ? "PASS" : "FAIL") . " formtips_max_width=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
