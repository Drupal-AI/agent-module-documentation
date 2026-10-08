#!/usr/bin/env bash
# Execution VERIFY: PASS when mobile_detect_is_mobile === true. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("mobile_detect.settings")->get("mobile_detect_is_mobile");
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
