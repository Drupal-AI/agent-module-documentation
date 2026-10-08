#!/usr/bin/env bash
# Introspection SETUP: attach a commerce_stock_level field field_csf_stock to the default
# product variation type and set its form-display widget to a known one, for an agent to read
# back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("commerce_product_variation", "field_csf_stock")) {
    FieldStorageConfig::create(["field_name" => "field_csf_stock", "entity_type" => "commerce_product_variation", "type" => "commerce_stock_level"])->save();
  }
  if (!FieldConfig::loadByName("commerce_product_variation", "default", "field_csf_stock")) {
    FieldConfig::create(["field_name" => "field_csf_stock", "entity_type" => "commerce_product_variation", "bundle" => "default", "label" => "Stock"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("commerce_product_variation.default.default");
  $fd->setComponent("field_csf_stock", ["type" => "commerce_stock_level_absolute", "region" => "content"])->save();
' >/dev/null 2>&1
echo "setup: field_csf_stock (commerce_stock_level) with widget commerce_stock_level_absolute"
