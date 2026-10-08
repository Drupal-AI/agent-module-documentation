#!/usr/bin/env bash
# Execution VERIFY: PASS when field_csf_wtask's form-display widget is
# commerce_stock_level_simple_transaction. Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("core.entity_form_display.commerce_product_variation.default.default")->get("content.field_csf_wtask.type");
  print (($t === "commerce_stock_level_simple_transaction") ? "PASS" : "FAIL") . " widget=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
