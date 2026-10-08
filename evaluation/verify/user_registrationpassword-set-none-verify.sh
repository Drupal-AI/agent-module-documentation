#!/usr/bin/env bash
# Execution VERIFY: PASS when registration mode is 'none' (NO_VERIFICATION).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("user_registrationpassword.settings")->get("registration");
  $ok = ($v === "none");
  print ($ok ? "PASS" : "FAIL") . " registration=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
