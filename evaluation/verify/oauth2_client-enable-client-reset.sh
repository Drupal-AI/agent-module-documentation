#!/usr/bin/env bash
# Execution RESET: create/ensure an oauth2_client config entity 'o2c_toggle' that is DISABLED
# (status FALSE), so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\oauth2_client\Entity\Oauth2Client;
  if ($e = Oauth2Client::load("o2c_toggle")) { $e->delete(); }
  Oauth2Client::create([
    "id" => "o2c_toggle", "label" => "O2C Toggle", "description" => "",
    "oauth2_client_plugin_id" => "authcode_example",
    "credential_provider" => "oauth2_client",
    "credential_storage_key" => "o2c_toggle_creds", "status" => FALSE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: oauth2_client entity o2c_toggle present and DISABLED"
