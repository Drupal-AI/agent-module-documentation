#!/usr/bin/env bash
# Execution RESET: uninstall leaflet_demo and delete leaflet_more_maps.settings, so neither
# the module nor the target custom map exist (verify MUST fail until the agent builds both).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall leaflet_demo -y >/dev/null 2>&1
drush php:eval '
  \Drupal::configFactory()->getEditable("leaflet_more_maps.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: leaflet_demo uninstalled; leaflet_more_maps.settings deleted"
