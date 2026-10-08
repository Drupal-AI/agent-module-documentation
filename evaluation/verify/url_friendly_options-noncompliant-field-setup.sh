#!/usr/bin/env bash
# Introspection SETUP: create a list_string field field_ufo_known on node.article whose
# allowed_values include a non-URL-friendly key ('bad_key' with an underscore) alongside a valid
# one. Created programmatically (bypasses the module's form validation). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ufo_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_ufo_known", "entity_type" => "node", "type" => "list_string",
      "settings" => ["allowed_values" => ["bad_key" => "Bad Key", "good-key" => "Good Key"]],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ufo_known")) {
    FieldConfig::create([
      "field_name" => "field_ufo_known", "entity_type" => "node",
      "bundle" => "article", "label" => "UFO Known",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node field_ufo_known allowed_values keys = bad_key, good-key"
