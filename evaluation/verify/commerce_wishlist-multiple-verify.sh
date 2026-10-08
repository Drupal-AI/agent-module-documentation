#!/usr/bin/env bash
# Execution VERIFY: PASS when commerce_wishlist.settings allow_multiple === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("commerce_wishlist.settings")->get("allow_multiple");
  print (($v === TRUE) ? "PASS" : "FAIL") . " allow_multiple=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
