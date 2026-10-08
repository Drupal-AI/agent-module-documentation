#!/usr/bin/env bash
# Introspection SETUP: create a daterange field field_vdf_m2 on Article and a View
# vdf_m2_ends whose daterange filter uses the views_daterange_filters plugin with the
# 'ends_by' operator. The agent must read the live view config to name the filter plugin id.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if (!FieldStorageConfig::loadByName("node", "field_vdf_m2")) {
    FieldStorageConfig::create([
      "field_name" => "field_vdf_m2", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vdf_m2")) {
    FieldConfig::create([
      "field_name" => "field_vdf_m2", "entity_type" => "node",
      "bundle" => "article", "label" => "VDF M2 Window",
    ])->save();
  }
  if ($v = View::load("vdf_m2_ends")) { $v->delete(); }
  View::create([
    "id" => "vdf_m2_ends", "label" => "VDF M2 Ends",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Master", "display_plugin" => "default",
      "position" => 0, "display_options" => ["filters" => [
        "field_vdf_m2_value" => [
          "id" => "field_vdf_m2_value", "table" => "node__field_vdf_m2",
          "field" => "field_vdf_m2_value",
          "plugin_id" => "views_daterange_filters_daterange",
          "operator" => "ends_by",
          "value" => ["value" => "2024-06-01T00:00:00"],
        ],
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vdf_m2_ends daterange filter plugin=views_daterange_filters_daterange operator=ends_by"
