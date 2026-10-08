#!/usr/bin/env bash
# Introspection SETUP: create an oauth2_client config entity 'o2c_known2' whose credentials
# are stored in Drupal State under a known key, so an agent can read the storage key back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\oauth2_client\Entity\Oauth2Client;
  if ($e = Oauth2Client::load("o2c_known2")) { $e->delete(); }
  Oauth2Client::create([
    "id" => "o2c_known2", "label" => "O2C Known Client 2", "description" => "",
    "oauth2_client_plugin_id" => "authcode_example",
    "credential_provider" => "oauth2_client",
    "credential_storage_key" => "o2c_secret_state", "status" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: oauth2_client entity o2c_known2 credential_provider=oauth2_client key=o2c_secret_state"
