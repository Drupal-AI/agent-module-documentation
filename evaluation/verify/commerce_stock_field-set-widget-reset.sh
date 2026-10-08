#!/usr/bin/env bash
# Execution RESET: attach field_csf_wtask (commerce_stock_level) to the default variation type
# with the SIMPLE widget, so verify FAILS until the agent changes it to the transaction widget.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("commerce_product_variation", "field_csf_wtask")) {
    FieldStorageConfig::create(["field_name" => "field_csf_wtask", "entity_type" => "commerce_product_variation", "type" => "commerce_stock_level"])->save();
  }
  if (!FieldConfig::loadByName("commerce_product_variation", "default", "field_csf_wtask")) {
    FieldConfig::create(["field_name" => "field_csf_wtask", "entity_type" => "commerce_product_variation", "bundle" => "default", "label" => "Stock"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("commerce_product_variation.default.default");
  $fd->setComponent("field_csf_wtask", ["type" => "commerce_stock_level_simple", "region" => "content"])->save();
' >/dev/null 2>&1
echo "reset: field_csf_wtask present with widget commerce_stock_level_simple"
