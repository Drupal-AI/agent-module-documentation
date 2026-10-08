#!/usr/bin/env bash
# Execution RESET (views_arg_order_sort): (re)create vaos_task_view with a Content: ID
# contextual filter but NO Multi-item Argument Order sort, so both verify scripts FAIL until the
# agent adds the sort. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vaos_task_view")) { $v->delete(); }
  View::create([
    "id" => "vaos_task_view", "label" => "VAOS Task View", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "arguments" => ["nid" => [
          "id" => "nid", "table" => "node_field_data", "field" => "nid", "plugin_id" => "node_nid",
        ]],
        "sorts" => [],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vaos_task_view has Content: ID contextual filter, no arg-order sort"
