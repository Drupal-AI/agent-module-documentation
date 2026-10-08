#!/usr/bin/env bash
# Introspection SETUP: write a known thunderforest_api_key into leaflet_more_maps.settings
# config (which does not exist by default) so an inspecting agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("leaflet_more_maps.settings")
    ->set("thunderforest_api_key", "lmm-eval-tfkey-7f3a9c")
    ->save();
' >/dev/null 2>&1
echo "setup: leaflet_more_maps.settings thunderforest_api_key=lmm-eval-tfkey-7f3a9c"
