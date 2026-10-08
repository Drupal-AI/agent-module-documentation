#!/usr/bin/env bash
# MEDIUM introspection SETUP: create a View (ren_known_view) that has a "REST export nested"
# display (plugin rest_export_nested) at path ren-known, so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("ren_known_view")) {
    View::create([
      "id" => "ren_known_view", "label" => "REN known view", "base_table" => "node_field_data",
      "display" => [
        "default" => ["id" => "default", "display_plugin" => "default", "display_title" => "Default", "position" => 0, "display_options" => []],
        "rest_export_1" => ["id" => "rest_export_1", "display_plugin" => "rest_export_nested", "display_title" => "REST export nested", "position" => 1,
          "display_options" => ["path" => "ren-known", "style" => ["type" => "serializer"], "row" => ["type" => "data_field"]]],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view ren_known_view with rest_export_nested display at path ren-known"
