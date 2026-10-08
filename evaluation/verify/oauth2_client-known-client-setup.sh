#!/usr/bin/env bash
# Introspection SETUP: create an oauth2_client config entity 'o2c_known' bound to the
# resource_owner_example plugin, so an agent can read back which plugin it uses. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\oauth2_client\Entity\Oauth2Client;
  if ($e = Oauth2Client::load("o2c_known")) { $e->delete(); }
  Oauth2Client::create([
    "id" => "o2c_known", "label" => "O2C Known Client", "description" => "",
    "oauth2_client_plugin_id" => "resource_owner_example",
    "credential_provider" => "oauth2_client",
    "credential_storage_key" => "o2c_known_creds", "status" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: oauth2_client entity o2c_known uses plugin resource_owner_example"
