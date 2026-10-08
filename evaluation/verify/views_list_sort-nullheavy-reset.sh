#!/usr/bin/env bash
# Execution RESET: create field_vls_null + view vls_null_view sorting by it with allowed_values ON
# but null_heavy OFF, so verify (wants null_heavy ON) FAILS until the agent enables it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if (!FieldStorageConfig::loadByName("node", "field_vls_null")) {
    FieldStorageConfig::create(["field_name" => "field_vls_null", "entity_type" => "node", "type" => "list_string",
      "settings" => ["allowed_values" => ["low" => "Low", "medium" => "Medium", "high" => "High"]]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_vls_null")) {
    FieldConfig::create(["field_name" => "field_vls_null", "entity_type" => "node", "bundle" => "article", "label" => "Null Priority"])->save();
  }
  if ($v = View::load("vls_null_view")) { $v->delete(); }
  View::create([
    "id" => "vls_null_view", "label" => "VLS Null View", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["sorts" => ["field_vls_null_value" => [
        "id" => "field_vls_null_value", "table" => "node__field_vls_null", "field" => "field_vls_null_value",
        "relationship" => "none", "plugin_id" => "sort_allowed_values", "order" => "ASC",
        "allowed_values" => "1", "null_heavy" => "0", "entity_type" => "node", "entity_field" => "field_vls_null",
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vls_null_view allowed_values=1 null_heavy=0"
