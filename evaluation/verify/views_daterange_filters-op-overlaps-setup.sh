#!/usr/bin/env bash
# Introspection SETUP: create a daterange field field_vdf_m1 on Article and a View
# vdf_m1_overlaps whose daterange filter uses the views_daterange_filters 'overlaps'
# operator, so an inspecting agent can read the operator back from live config.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if (!FieldStorageConfig::loadByName("node", "field_vdf_m1")) {
    FieldStorageConfig::create([
      "field_name" => "field_vdf_m1", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vdf_m1")) {
    FieldConfig::create([
      "field_name" => "field_vdf_m1", "entity_type" => "node",
      "bundle" => "article", "label" => "VDF M1 Window",
    ])->save();
  }
  if ($v = View::load("vdf_m1_overlaps")) { $v->delete(); }
  View::create([
    "id" => "vdf_m1_overlaps", "label" => "VDF M1 Overlaps",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Master", "display_plugin" => "default",
      "position" => 0, "display_options" => ["filters" => [
        "field_vdf_m1_value" => [
          "id" => "field_vdf_m1_value", "table" => "node__field_vdf_m1",
          "field" => "field_vdf_m1_value",
          "plugin_id" => "views_daterange_filters_daterange",
          "operator" => "overlaps",
          "value" => ["min" => "2024-01-01T00:00:00", "max" => "2024-01-31T00:00:00"],
        ],
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vdf_m1_overlaps has daterange filter operator=overlaps on field_vdf_m1"
