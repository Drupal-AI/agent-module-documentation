#!/usr/bin/env bash
# Execution RESET: ensure the gapi_task service-account config entity does NOT exist, so verify
# FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\google_api_client\Entity\GoogleApiServiceClient;
  if ($e = GoogleApiServiceClient::load("gapi_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: gapi_task absent"
