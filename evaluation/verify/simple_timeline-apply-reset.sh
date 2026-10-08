#!/usr/bin/env bash
# Execution RESET: (re)create a view st_task whose default display uses the plain 'default'
# (unformatted list) style, so verify FAILS until the agent switches it to simple_timeline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("st_task")) { $v->delete(); }
  View::create([
    "id" => "st_task", "label" => "ST Task", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "style" => ["type" => "default", "options" => []],
        "row" => ["type" => "fields"],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "reset: view st_task style=default"
