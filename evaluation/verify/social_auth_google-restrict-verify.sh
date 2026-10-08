#!/usr/bin/env bash
# Execution VERIFY: PASS when restricted_domain === acme.example. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::config("social_auth_google.settings")->get("restricted_domain");
  $ok = ($d === "acme.example");
  print ($ok ? "PASS" : "FAIL") . " restricted_domain=" . var_export($d, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
