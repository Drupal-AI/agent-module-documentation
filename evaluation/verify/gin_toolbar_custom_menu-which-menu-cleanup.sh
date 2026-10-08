#!/usr/bin/env bash
# Cleanup: delete the settings config (restores baseline - config absent).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gin_toolbar_custom_menu.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: gin_toolbar_custom_menu.settings deleted"
