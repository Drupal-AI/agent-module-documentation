#!/usr/bin/env bash
# Execution RESET: ensure field_vdf_task exists on Article and (re)create view vdf_switch
# with a daterange filter using plugin views_daterange_filters_daterange but operator
# 'includes' (single value). The agent must change the operator to 'overlaps'. Verify FAILS
# in this reset state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if (!FieldStorageConfig::loadByName("node", "field_vdf_task")) {
    FieldStorageConfig::create([
      "field_name" => "field_vdf_task", "entity_type" => "node",
      "type" => "daterange", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vdf_task")) {
    FieldConfig::create([
      "field_name" => "field_vdf_task", "entity_type" => "node",
      "bundle" => "article", "label" => "VDF Task Window",
    ])->save();
  }
  if ($v = View::load("vdf_switch")) { $v->delete(); }
  View::create([
    "id" => "vdf_switch", "label" => "VDF Switch",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Master", "display_plugin" => "default",
      "position" => 0, "display_options" => ["filters" => [
        "field_vdf_task_value" => [
          "id" => "field_vdf_task_value", "table" => "node__field_vdf_task",
          "field" => "field_vdf_task_value",
          "plugin_id" => "views_daterange_filters_daterange",
          "operator" => "includes",
          "value" => ["value" => "2024-01-01T00:00:00"],
        ],
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vdf_switch daterange filter operator=includes (needs change to overlaps)"
