#!/usr/bin/env bash
# Introspection CLEANUP: delete the config object to restore baseline (no saved settings).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("x_frame_options_configuration.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: x_frame_options_configuration.settings deleted (baseline)"
