#!/usr/bin/env bash
# Introspection SETUP: create a Length dimension field field_dim_known_len on Article and set the
# Length component's min to 5, so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dim_known_len")) {
    FieldStorageConfig::create([
      "field_name" => "field_dim_known_len", "entity_type" => "node", "type" => "length_field_type",
    ])->save();
  }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  if (!FieldConfig::loadByName("node", "article", "field_dim_known_len")) {
    FieldConfig::create([
      "field_name" => "field_dim_known_len", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Length",
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_dim_known_len");
  $fc->setSetting("length", ["factor" => 1, "min" => 5, "max" => "", "prefix" => "", "suffix" => ""]);
  $fc->save();
' >/dev/null 2>&1
echo "setup: node.article field_dim_known_len length.min=5"
