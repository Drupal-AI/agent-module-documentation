#!/usr/bin/env bash
# Introspection SETUP: create two list_string fields on node.article - field_ufo_ok (all keys
# URL-friendly) and field_ufo_bad (contains an underscore key). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $defs = [
    "field_ufo_ok" => ["red" => "Red", "dark-blue" => "Dark Blue"],
    "field_ufo_bad" => ["green" => "Green", "light_grey" => "Light Grey"],
  ];
  foreach ($defs as $name => $vals) {
    if (!FieldStorageConfig::loadByName("node", $name)) {
      FieldStorageConfig::create([
        "field_name" => $name, "entity_type" => "node", "type" => "list_string",
        "settings" => ["allowed_values" => $vals],
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $name)) {
      FieldConfig::create([
        "field_name" => $name, "entity_type" => "node", "bundle" => "article",
        "label" => strtoupper($name),
      ])->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ufo_ok (red, dark-blue) and field_ufo_bad (green, light_grey)"
