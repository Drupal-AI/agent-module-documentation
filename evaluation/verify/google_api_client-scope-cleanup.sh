#!/usr/bin/env bash
# Introspection CLEANUP: delete gapi_scope. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\google_api_client\Entity\GoogleApiServiceClient;
  if ($e = GoogleApiServiceClient::load("gapi_scope")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: gapi_scope removed"
