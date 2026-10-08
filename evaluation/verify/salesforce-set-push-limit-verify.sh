#!/usr/bin/env bash
# Execution VERIFY: PASS when salesforce.settings global_push_limit === 500. Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("salesforce.settings")->get("global_push_limit");
  print (($v === 500) ? "PASS" : "FAIL") . " global_push_limit=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
