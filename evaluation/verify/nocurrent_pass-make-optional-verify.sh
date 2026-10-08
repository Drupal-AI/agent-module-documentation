#!/usr/bin/env bash
# Execution VERIFY: PASS when nocurrent_pass_disabled === TRUE (current password not required).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("nocurrent_pass.settings")->get("nocurrent_pass_disabled");
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " nocurrent_pass_disabled=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
