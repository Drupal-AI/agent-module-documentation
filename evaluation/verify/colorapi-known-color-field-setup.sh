#!/usr/bin/env bash
# Introspection SETUP: create a colorapi_color_field field named field_cai_swatch on Article so
# an inspecting agent can find which field is a Color field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cai_swatch")) {
    FieldStorageConfig::create([
      "field_name" => "field_cai_swatch", "entity_type" => "node",
      "type" => "colorapi_color_field",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cai_swatch")) {
    FieldConfig::create([
      "field_name" => "field_cai_swatch", "entity_type" => "node",
      "bundle" => "article", "label" => "CAI Swatch",
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: field_cai_swatch (colorapi_color_field) on node.article"
