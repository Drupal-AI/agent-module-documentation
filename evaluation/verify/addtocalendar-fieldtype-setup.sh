#!/usr/bin/env bash
# Introspection SETUP: add a field of the module's own add_to_calendar_field type to Article so an
# agent can discover which field uses that dedicated type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_atc_evt")) {
    FieldStorageConfig::create([
      "field_name" => "field_atc_evt", "entity_type" => "node", "type" => "add_to_calendar_field",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_atc_evt")) {
    FieldConfig::create([
      "field_name" => "field_atc_evt", "entity_type" => "node",
      "bundle" => "article", "label" => "Event Calendar Button",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_atc_evt (type add_to_calendar_field) created"
