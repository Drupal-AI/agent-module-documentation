#!/usr/bin/env bash
# Execution RESET: set directive to DENY so verify FAILS until the agent changes it to SAMEORIGIN.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("x_frame_options_configuration.settings")->set("x_frame_options_configuration.directive", "DENY")->set("x_frame_options_configuration.allow-from-uri", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: directive=DENY"
