#!/usr/bin/env bash
# Execution RESET: create list_string field field_vls_task on Article and a view vls_task_view
# that sorts by it with the sort_allowed_values handler but 'Sort by allowed values' OFF
# (allowed_values=0), so verify FAILS until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if (!FieldStorageConfig::loadByName("node", "field_vls_task")) {
    FieldStorageConfig::create(["field_name" => "field_vls_task", "entity_type" => "node", "type" => "list_string",
      "settings" => ["allowed_values" => ["low" => "Low", "medium" => "Medium", "high" => "High"]]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vls_task")) {
    FieldConfig::create(["field_name" => "field_vls_task", "entity_type" => "node", "bundle" => "article", "label" => "Task Priority"])->save();
  }
  if ($v = View::load("vls_task_view")) { $v->delete(); }
  View::create([
    "id" => "vls_task_view", "label" => "VLS Task View", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["sorts" => ["field_vls_task_value" => [
        "id" => "field_vls_task_value", "table" => "node__field_vls_task", "field" => "field_vls_task_value",
        "relationship" => "none", "plugin_id" => "sort_allowed_values", "order" => "ASC",
        "allowed_values" => "0", "null_heavy" => "0", "entity_type" => "node", "entity_field" => "field_vls_task",
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vls_task_view sort field_vls_task_value has allowed_values=0 (off)"
