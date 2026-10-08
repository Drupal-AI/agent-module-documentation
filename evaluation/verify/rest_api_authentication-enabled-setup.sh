#!/usr/bin/env bash
# Introspection SETUP: turn the master API-authentication switch ON (enable_authentication=1)
# so an agent can read whether API protection is active. Local config only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("rest_api_authentication.settings")->set("enable_authentication", 1)->save();' >/dev/null 2>&1
echo "setup: rest_api_authentication.settings enable_authentication=1"
