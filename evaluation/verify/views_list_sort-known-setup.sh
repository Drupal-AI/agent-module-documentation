#!/usr/bin/env bash
# Introspection SETUP: create a list_string field field_vls_known (low/medium/high) on Article and
# a view vls_known_view whose default display sorts by that field using views_list_sort's
# sort_allowed_values handler with 'Sort by allowed values' ON. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if (!FieldStorageConfig::loadByName("node", "field_vls_known")) {
    FieldStorageConfig::create(["field_name" => "field_vls_known", "entity_type" => "node", "type" => "list_string",
      "settings" => ["allowed_values" => ["low" => "Low", "medium" => "Medium", "high" => "High"]]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vls_known")) {
    FieldConfig::create(["field_name" => "field_vls_known", "entity_type" => "node", "bundle" => "article", "label" => "Known Priority"])->save();
  }
  if ($v = View::load("vls_known_view")) { $v->delete(); }
  View::create([
    "id" => "vls_known_view", "label" => "VLS Known View", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["sorts" => ["field_vls_known_value" => [
        "id" => "field_vls_known_value", "table" => "node__field_vls_known", "field" => "field_vls_known_value",
        "relationship" => "none", "plugin_id" => "sort_allowed_values", "order" => "ASC",
        "allowed_values" => "1", "null_heavy" => "0", "entity_type" => "node", "entity_field" => "field_vls_known",
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vls_known_view sorts field_vls_known_value via sort_allowed_values (allowed_values=1)"
