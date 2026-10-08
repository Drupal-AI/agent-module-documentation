#!/usr/bin/env bash
# Execution VERIFY: PASS when purposeExternalNoReferrer === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("linkpurpose.settings")->get("purposeExternalNoReferrer");
  print (($v === TRUE) ? "PASS" : "FAIL") . " purposeExternalNoReferrer=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
