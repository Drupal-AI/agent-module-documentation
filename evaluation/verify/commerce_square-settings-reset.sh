#!/usr/bin/env bash
# Execution RESET: clear sandbox credentials on commerce_square.settings, so verify FAILs
# until the agent sets them.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_square.settings")->set("sandbox_app_id", "")->set("sandbox_access_token", "")->save();' >/dev/null 2>&1
echo "reset: sandbox_app_id= sandbox_access_token="
