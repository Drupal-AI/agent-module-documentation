#!/usr/bin/env bash
# Introspection CLEANUP: restore empty sandbox_app_id (shipped state).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_square.settings")->set("sandbox_app_id", "")->save();' >/dev/null 2>&1
echo "cleanup: sandbox_app_id cleared"
