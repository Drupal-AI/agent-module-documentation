#!/usr/bin/env bash
# Execution RESET: create views_natural_sort_demo (node view) whose Title sort is STANDARD ascending
# (plugin_id 'standard', order 'ASC') so verify FAILS until switched to natural. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("views_natural_sort_demo")) { $v->delete(); }
  View::create([
    "id" => "views_natural_sort_demo", "label" => "VNS demo",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "sorts" => ["title" => ["id" => "title", "table" => "node_field_data", "field" => "title", "entity_type" => "node", "entity_field" => "title", "plugin_id" => "standard", "order" => "ASC"]],
        "pager" => ["type" => "none"],
      ]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: views_natural_sort_demo Title sort is standard ASC"
