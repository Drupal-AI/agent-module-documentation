#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("social_auth_google.settings")->set("client_id","")->set("client_secret","")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: social_auth_google.settings credentials cleared"
