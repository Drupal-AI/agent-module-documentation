#!/usr/bin/env bash
# Execution VERIFY: PASS when the expected API-key token (api_token) is set to EVAL-TOKEN-9x
# in rest_api_authentication.settings. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("rest_api_authentication.settings")->get("api_token");
  $ok = ($v === "EVAL-TOKEN-9x");
  print ($ok ? "PASS" : "FAIL") . " api_token=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
