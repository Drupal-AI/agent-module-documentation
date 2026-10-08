#!/usr/bin/env bash
# Introspection SETUP: create a google_api_service_client CONFIG entity gapi_probe configured
# for the Drive + Calendar services (no live Google calls needed - pure config), so an agent can
# read back which services it targets. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\google_api_client\Entity\GoogleApiServiceClient;
  if (!GoogleApiServiceClient::load("gapi_probe")) {
    GoogleApiServiceClient::create([
      "id" => "gapi_probe",
      "label" => "GAPI Probe Service Account",
      "auth_config" => "{\"type\":\"service_account\",\"project_id\":\"gapi-probe\"}",
      "services" => ["drive", "calendar"],
      "scopes" => ["https://www.googleapis.com/auth/drive.readonly"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: google_api_service_client gapi_probe (services drive,calendar)"
