#!/usr/bin/env bash
# Execution RESET: (re)create vri_task_view whose default display uses the plain
# 'default' (Unformatted list) style, NOT row_insert, so verify FAILS until the agent
# switches the style to row_insert. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vri_task_view")) { $v->delete(); }
  View::create([
    "id" => "vri_task_view", "label" => "VRI Task View", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "style" => ["type" => "default", "options" => []],
        "row" => ["type" => "fields"],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vri_task_view default display uses style=default (not row_insert)"
