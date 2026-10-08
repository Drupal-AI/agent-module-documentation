#!/usr/bin/env bash
# Execution RESET: blank restricted_domain so verify FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("social_auth_google.settings")->set("restricted_domain","")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: social_auth_google.settings restricted_domain blanked"
