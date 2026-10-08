#!/usr/bin/env bash
# Execution VERIFY: PASS when salesforce.settings standalone === true. Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("salesforce.settings")->get("standalone");
  print (($v === TRUE) ? "PASS" : "FAIL") . " standalone=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
