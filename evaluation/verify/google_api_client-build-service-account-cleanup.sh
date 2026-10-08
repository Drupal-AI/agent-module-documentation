#!/usr/bin/env bash
# Execution CLEANUP: delete gapi_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\google_api_client\Entity\GoogleApiServiceClient;
  if ($e = GoogleApiServiceClient::load("gapi_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: gapi_task removed"
