#!/usr/bin/env bash
# Introspection SETUP: create a google_api_service_client config entity gapi_scope with a known,
# distinctive OAuth scope so an agent can read the configured scope back from config. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\google_api_client\Entity\GoogleApiServiceClient;
  if (!GoogleApiServiceClient::load("gapi_scope")) {
    GoogleApiServiceClient::create([
      "id" => "gapi_scope",
      "label" => "GAPI Scope Probe",
      "auth_config" => "{\"type\":\"service_account\"}",
      "services" => ["sheets"],
      "scopes" => ["https://www.googleapis.com/auth/spreadsheets.readonly"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: gapi_scope scope=spreadsheets.readonly"
