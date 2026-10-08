#!/usr/bin/env bash
# Introspection SETUP: create a Range (decimal) field field_range_price on Article and give it
# a known set of range field settings (min/max plus FIELD/FROM/TO/COMBINED prefixes and
# suffixes), so an inspecting agent can read them back from
# field.field.node.article.field_range_price. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_range_price")) {
    FieldStorageConfig::create([
      "field_name" => "field_range_price", "entity_type" => "node",
      "type" => "range_decimal", "settings" => ["precision" => 10, "scale" => 2],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_range_price");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_range_price", "entity_type" => "node",
      "bundle" => "article", "label" => "Price Range",
    ]);
  }
  $fc->setSettings([
    "min" => 10,
    "max" => 5000,
    "field" => ["prefix" => "", "suffix" => " per night"],
    "from" => ["prefix" => "$", "suffix" => ""],
    "to" => ["prefix" => "$", "suffix" => ""],
    "combined" => ["prefix" => "flat $", "suffix" => ""],
  ])->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_range_price", ["type" => "range", "weight" => 60, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_range_price (range_decimal) min=10 max=5000 to.prefix=\$ field.suffix=' per night'"
