#!/usr/bin/env bash
# Introspection CLEANUP: remove enable_authentication (baseline: unset = protection off).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("rest_api_authentication.settings")->clear("enable_authentication")->save();' >/dev/null 2>&1
echo "cleanup: enable_authentication cleared"
