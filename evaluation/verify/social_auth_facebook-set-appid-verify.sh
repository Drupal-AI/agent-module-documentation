#!/usr/bin/env bash
# Execution VERIFY: PASS when social_auth_facebook.settings client_id === 'fb_app_probe_123456'.
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("social_auth_facebook.settings")->get("client_id");
  print (($v==="fb_app_probe_123456") ? "PASS" : "FAIL") . " client_id=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
