#!/usr/bin/env bash
# Execution RESET: (re)create a view st_pos using simple_timeline with position_items=alternate,
# so verify FAILS until the agent changes it to 'right'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("st_pos")) { $v->delete(); }
  View::create([
    "id" => "st_pos", "label" => "ST Pos", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "style" => ["type" => "simple_timeline", "options" => ["position_items" => "alternate", "position_marker" => "marker-center", "class" => "item-list", "wrapper_class" => "wrapper-list"]],
        "row" => ["type" => "fields"],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "reset: view st_pos simple_timeline position_items=alternate"
