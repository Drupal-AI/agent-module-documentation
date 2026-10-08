#!/usr/bin/env bash
# Execution VERIFY: PASS when the Iubenda privacy policy code is set to 7654321.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("iubenda_integration.settings")->get("iubenda_integration_policy_code");
  $ok = ((string) $v === "7654321");
  print ($ok ? "PASS" : "FAIL") . " iubenda_integration_policy_code=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
