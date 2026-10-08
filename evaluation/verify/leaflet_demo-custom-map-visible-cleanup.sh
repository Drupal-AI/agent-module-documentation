#!/usr/bin/env bash
# Introspection CLEANUP: remove the custom map config and uninstall leaflet_demo, restoring
# the shared site's baseline (leaflet_more_maps.settings absent, leaflet_demo disabled).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("leaflet_more_maps.settings")->delete();
' >/dev/null 2>&1
drush pm:uninstall leaflet_demo -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: leaflet_more_maps.settings deleted; leaflet_demo uninstalled (baseline restored)"
