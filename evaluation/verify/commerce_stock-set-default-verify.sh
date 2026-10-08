#!/usr/bin/env bash
# Execution VERIFY: PASS when commerce_stock.service_manager default_service_id === local_stock.
# Pure config read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::config("commerce_stock.service_manager")->get("default_service_id");
  print (($s === "local_stock") ? "PASS" : "FAIL") . " default_service_id=" . var_export($s, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
