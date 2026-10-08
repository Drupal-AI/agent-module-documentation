#!/usr/bin/env bash
# Execution CLEANUP: clear sandbox credentials again. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_square.settings")->set("sandbox_app_id", "")->set("sandbox_access_token", "")->save();' >/dev/null 2>&1
echo "cleanup: sandbox credentials cleared"
