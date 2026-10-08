#!/usr/bin/env bash
# Introspection CLEANUP: delete leaflet_more_maps.settings entirely, restoring the module's
# true baseline (the config object does not ship/exist by default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("leaflet_more_maps.settings")->delete();
' >/dev/null 2>&1
echo "cleanup: leaflet_more_maps.settings deleted"
