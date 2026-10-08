#!/usr/bin/env bash
# Execution VERIFY: PASS when lightning_api.settings bundle_docs === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("lightning_api.settings")->get("bundle_docs");
  print (($v===TRUE) ? "PASS" : "FAIL") . " bundle_docs=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
