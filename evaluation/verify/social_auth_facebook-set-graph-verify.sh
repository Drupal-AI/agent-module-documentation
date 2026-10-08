#!/usr/bin/env bash
# Execution VERIFY: PASS when social_auth_facebook.settings graph_version === '17.0'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("social_auth_facebook.settings")->get("graph_version");
  print (($v==="17.0") ? "PASS" : "FAIL") . " graph_version=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
