#!/usr/bin/env bash
# Introspection SETUP: enable leaflet_demo AND write a known custom map to
# leaflet_more_maps.settings, so an inspecting agent must connect the two: the demo page
# renders whatever leaflet_map_get_info() returns, which includes leaflet_more_maps' custom
# maps. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install leaflet_demo -y >/dev/null 2>&1
drush php:eval '
  \Drupal::configFactory()->getEditable("leaflet_more_maps.settings")
    ->set("leaflet_more_maps_custom_maps", [
      1 => [
        "map-key" => "LMM Demo Showcase Combo",
        "layer-keys" => ["google-satellite layer", "opentopomap layer"],
        "reverse-order" => FALSE,
      ],
    ])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: leaflet_demo enabled; leaflet_more_maps custom map 'LMM Demo Showcase Combo' configured"
