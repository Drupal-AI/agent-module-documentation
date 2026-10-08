#!/usr/bin/env bash
# Introspection SETUP: create a google_map_field field on Article so an agent can find which
# field uses that type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_gmf_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_gmf_known", "entity_type" => "node", "type" => "google_map_field",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_gmf_known")) {
    FieldConfig::create([
      "field_name" => "field_gmf_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Location Map",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_gmf_known (type google_map_field) created"
