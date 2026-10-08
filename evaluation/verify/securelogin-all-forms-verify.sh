#!/usr/bin/env bash
# Execution VERIFY: PASS when securelogin.settings all_forms === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("securelogin.settings")->get("all_forms");
  print (($v === TRUE) ? "PASS" : "FAIL") . " all_forms=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
