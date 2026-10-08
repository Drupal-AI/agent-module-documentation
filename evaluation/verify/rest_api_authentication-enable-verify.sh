#!/usr/bin/env bash
# Execution VERIFY: PASS when API authentication is enabled (enable_authentication === 1) in
# rest_api_authentication.settings. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("rest_api_authentication.settings")->get("enable_authentication");
  $ok = ((int) $v === 1);
  print ($ok ? "PASS" : "FAIL") . " enable_authentication=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
