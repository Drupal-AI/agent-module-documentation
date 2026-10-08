#!/usr/bin/env bash
# Introspection SETUP: write a known custom map definition into leaflet_more_maps.settings
# (leaflet_more_maps_custom_maps) so an inspecting agent can read back its map-key and
# selected layers. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("leaflet_more_maps.settings")
    ->set("leaflet_more_maps_custom_maps", [
      1 => [
        "map-key" => "LMM Weather Combo",
        "layer-keys" => ["osm-cycle layer", "stamen-watercolor layer"],
        "reverse-order" => FALSE,
      ],
    ])
    ->save();
' >/dev/null 2>&1
echo "setup: leaflet_more_maps.settings custom map #1 = LMM Weather Combo (osm-cycle layer, stamen-watercolor layer)"
