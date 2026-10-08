#!/usr/bin/env bash
# Execution RESET: delete leaflet_more_maps.settings so no custom map named "LMM Verify Combo"
# exists (verify MUST fail until the agent assembles it), then bust the leaflet_map_info
# cache. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("leaflet_more_maps.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: leaflet_more_maps.settings deleted, cache rebuilt"
