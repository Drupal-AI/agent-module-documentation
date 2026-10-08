#!/usr/bin/env bash
# Execution RESET: delete the config object (no directive set) so verify FAILS until the agent
# sets DENY. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("x_frame_options_configuration.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: x_frame_options config deleted (no directive)"
