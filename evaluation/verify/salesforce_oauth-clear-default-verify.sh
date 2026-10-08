#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("salesforce.settings")->get("salesforce_auth_provider");
  print (($v === "") ? "PASS" : "FAIL") . " salesforce_auth_provider=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
