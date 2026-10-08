#!/usr/bin/env bash
# Introspection SETUP: create a plugin-collection field on Article using the derived field type
# plugin:condition (the "plugin" field type keyed to the core Condition plugin type), so an
# inspecting agent can read back which plugin type the field references. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_plugin_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_plugin_known", "entity_type" => "node", "type" => "plugin:condition",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_plugin_known")) {
    FieldConfig::create([
      "field_name" => "field_plugin_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Plugin Ref",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_plugin_known has field type plugin:condition"
