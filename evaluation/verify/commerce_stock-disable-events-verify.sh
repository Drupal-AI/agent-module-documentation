#!/usr/bin/env bash
# Execution VERIFY: PASS when stock_events_plugin_id === disabled_stock_events. Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::config("commerce_stock.service_manager")->get("stock_events_plugin_id");
  print (($s === "disabled_stock_events") ? "PASS" : "FAIL") . " stock_events_plugin_id=" . var_export($s, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
