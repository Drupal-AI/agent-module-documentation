#!/usr/bin/env bash
# Execution RESET: delete leaflet_more_maps.settings so no thunderforest_api_key is configured
# (verify MUST fail until the agent sets one), then bust the leaflet_map_info cache so the
# unkeyed URL is what a live lookup returns. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("leaflet_more_maps.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: leaflet_more_maps.settings deleted, cache rebuilt"
