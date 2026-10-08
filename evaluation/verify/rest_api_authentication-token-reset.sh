#!/usr/bin/env bash
# Execution RESET: clear the api_token so verify FAILS until the agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("rest_api_authentication.settings")->clear("api_token")->save();' >/dev/null 2>&1
echo "reset: api_token cleared"
