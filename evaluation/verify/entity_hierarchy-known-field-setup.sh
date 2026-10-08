#!/usr/bin/env bash
# MEDIUM introspection SETUP: add an entity_reference_hierarchy field field_eh_parent to
# Article so an agent can read it back. Storage is created in its own process first because
# creating the storage and the field instance in one process is unreliable for this field type.
set -uo pipefail
cd /var/www/html
# 1. Field storage (own bootstrap so it is committed before the instance is created).
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  if (!FieldStorageConfig::loadByName("node", "field_eh_parent")) {
    FieldStorageConfig::create([
      "field_name" => "field_eh_parent", "entity_type" => "node",
      "type" => "entity_reference_hierarchy", "cardinality" => 1,
      "settings" => ["target_type" => "node"],
    ])->save();
  }
' >/dev/null 2>&1
# 2. Field instance on the Article bundle (default:node selection handler).
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  if (!FieldConfig::loadByName("node", "article", "field_eh_parent")) {
    FieldConfig::create([
      "field_name" => "field_eh_parent", "entity_type" => "node", "bundle" => "article",
      "label" => "Parent page",
      "settings" => ["handler" => "default:node", "handler_settings" => ["target_bundles" => ["article" => "article"]]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_eh_parent (entity_reference_hierarchy)"
