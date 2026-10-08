#!/usr/bin/env bash
# Introspection SETUP: create an oauth2_client config entity 'o2cex_known' bound to the example
# submodule's authcode_access_example plugin, so an agent can read back which plugin it uses.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\oauth2_client\Entity\Oauth2Client;
  if ($e = Oauth2Client::load("o2cex_known")) { $e->delete(); }
  Oauth2Client::create([
    "id" => "o2cex_known", "label" => "O2CEX Known", "description" => "",
    "oauth2_client_plugin_id" => "authcode_access_example",
    "credential_provider" => "oauth2_client",
    "credential_storage_key" => "o2cex_known_creds", "status" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: o2cex_known uses plugin authcode_access_example"
