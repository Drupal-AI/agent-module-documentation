#!/usr/bin/env bash
# Introspection SETUP: create a view st_demo whose default display uses the simple_timeline
# style with position_items=left, so the agent can read the item position back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("st_demo")) {
    View::create([
      "id" => "st_demo", "label" => "ST Demo", "base_table" => "node_field_data",
      "display" => ["default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "style" => ["type" => "simple_timeline", "options" => ["position_items" => "left", "position_marker" => "marker-center", "class" => "item-list", "wrapper_class" => "wrapper-list"]],
          "row" => ["type" => "fields"],
        ],
      ]],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: view st_demo simple_timeline position_items=left"
