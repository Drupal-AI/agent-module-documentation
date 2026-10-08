#!/usr/bin/env bash
# Execution VERIFY: PASS when transactions_aggregation_mode === real-time. Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::config("commerce_stock_local.transactions")->get("transactions_aggregation_mode");
  print (($m === "real-time") ? "PASS" : "FAIL") . " mode=" . var_export($m, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
