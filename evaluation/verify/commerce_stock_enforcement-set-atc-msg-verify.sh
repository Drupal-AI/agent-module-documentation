#!/usr/bin/env bash
# Execution VERIFY: PASS when insufficient_stock_add_to_cart_zero_in_cart ===
# 'Only %qty available, you asked for %qty_asked.'. Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::config("commerce_stock_enforcement.settings")->get("insufficient_stock_add_to_cart_zero_in_cart");
  $ok = ($m === "Only %qty available, you asked for %qty_asked.");
  print (($ok) ? "PASS" : "FAIL") . " msg=" . var_export($m, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
