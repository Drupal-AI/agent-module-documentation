#!/usr/bin/env bash
# MEDIUM introspection SETUP: create a View (vgj_known_view) with a GeoJSON export display whose
# GeoJSON style uses the latlon data source, so an agent can read the geometry source back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("vgj_known_view")) {
    View::create([
      "id" => "vgj_known_view", "label" => "VGJ known view", "base_table" => "node_field_data",
      "display" => [
        "default" => ["id" => "default", "display_plugin" => "default", "display_title" => "Default", "position" => 0, "display_options" => []],
        "geojson_1" => ["id" => "geojson_1", "display_plugin" => "geojson_export", "display_title" => "GeoJSON export", "position" => 1,
          "display_options" => ["path" => "vgj-known", "style" => ["type" => "geojson", "options" => ["data_source" => ["value" => "latlon", "latitude" => "field_lat", "longitude" => "field_lon"]]], "row" => ["type" => "data_field"]]],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vgj_known_view geojson_export display, style geojson, data_source=latlon"
