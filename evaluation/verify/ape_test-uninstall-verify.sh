#!/usr/bin/env bash
# Execution VERIFY: PASS when ape_test is NOT enabled (absent from core.extension). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::config("core.extension")->get("module.ape_test");
  print (($w === NULL) ? "PASS" : "FAIL") . " weight=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
