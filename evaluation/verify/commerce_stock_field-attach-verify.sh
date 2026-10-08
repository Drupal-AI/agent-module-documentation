#!/usr/bin/env bash
# Execution VERIFY: PASS when a field named field_csf_task of type commerce_stock_level exists
# on the default product variation type. Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fc = \Drupal::config("field.field.commerce_product_variation.default.field_csf_task");
  $fs = \Drupal::config("field.storage.commerce_product_variation.field_csf_task");
  $type = $fs->get("type");
  $ok = ($fc->get("field_name") === "field_csf_task" && $type === "commerce_stock_level");
  print (($ok) ? "PASS" : "FAIL") . " field=" . var_export($fc->get("field_name"), TRUE) . " type=" . var_export($type, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
