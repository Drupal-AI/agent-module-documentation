#!/usr/bin/env bash
# Introspection SETUP: set a known extra scope. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("social_auth_google.settings")->set("scopes","https://www.googleapis.com/auth/youtube.readonly")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: social_auth_google.settings scopes=youtube.readonly"
