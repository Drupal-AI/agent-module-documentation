#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("social_auth_google.settings")->set("scopes","")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: social_auth_google.settings scopes cleared"
