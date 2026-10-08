#!/usr/bin/env bash
# Introspection CLEANUP: remove the applications map and default_application_id (baseline: unset).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("rest_api_authentication.settings")->clear("applications")->clear("default_application_id")->save();' >/dev/null 2>&1
echo "cleanup: applications + default_application_id cleared"
