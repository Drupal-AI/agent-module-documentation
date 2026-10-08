#!/usr/bin/env bash
# Execution CLEANUP: delete leaflet_more_maps.settings, restoring the module's true baseline
# (no config object). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("leaflet_more_maps.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: leaflet_more_maps.settings deleted, cache rebuilt"
