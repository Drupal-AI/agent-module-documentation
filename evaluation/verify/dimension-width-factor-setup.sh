#!/usr/bin/env bash
# Introspection SETUP: create an Area dimension field field_dim_known_area on Article and set the
# Width component's factor to 2, so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dim_known_area")) {
    FieldStorageConfig::create([
      "field_name" => "field_dim_known_area", "entity_type" => "node", "type" => "area_field_type",
    ])->save();
  }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  if (!FieldConfig::loadByName("node", "article", "field_dim_known_area")) {
    FieldConfig::create([
      "field_name" => "field_dim_known_area", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Area",
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_dim_known_area");
  $fc->setSetting("width", ["factor" => 2, "min" => "", "max" => "", "prefix" => "", "suffix" => ""]);
  $fc->save();
' >/dev/null 2>&1
echo "setup: node.article field_dim_known_area width.factor=2"
