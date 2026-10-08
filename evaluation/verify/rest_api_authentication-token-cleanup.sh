#!/usr/bin/env bash
# Execution CLEANUP: restore baseline (clear api_token).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("rest_api_authentication.settings")->clear("api_token")->save();' >/dev/null 2>&1
echo "cleanup: api_token cleared"
