#!/usr/bin/env bash
# Execution RESET: blank client_id/client_secret so verify FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("social_auth_google.settings")->set("client_id","")->set("client_secret","")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: social_auth_google.settings client_id/client_secret blanked"
