#!/usr/bin/env bash
# Execution VERIFY: PASS when insufficient_stock_cart === 'Only %qty of %name left in our warehouse.'.
# Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::config("commerce_stock_enforcement.settings")->get("insufficient_stock_cart");
  $ok = ($m === "Only %qty of %name left in our warehouse.");
  print (($ok) ? "PASS" : "FAIL") . " msg=" . var_export($m, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
