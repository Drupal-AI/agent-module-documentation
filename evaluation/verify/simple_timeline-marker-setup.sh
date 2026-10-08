#!/usr/bin/env bash
# Introspection SETUP: create a view st_marker using simple_timeline with
# position_marker=marker-bottom. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("st_marker")) {
    View::create([
      "id" => "st_marker", "label" => "ST Marker", "base_table" => "node_field_data",
      "display" => ["default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "style" => ["type" => "simple_timeline", "options" => ["position_items" => "alternate", "position_marker" => "marker-bottom", "class" => "item-list", "wrapper_class" => "wrapper-list"]],
          "row" => ["type" => "fields"],
        ],
      ]],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: view st_marker simple_timeline position_marker=marker-bottom"
