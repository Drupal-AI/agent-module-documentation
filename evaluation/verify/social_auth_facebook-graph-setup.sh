#!/usr/bin/env bash
# Introspection SETUP: create social_auth_facebook.settings with a distinctive Graph API version
# so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("social_auth_facebook.settings")
    ->set("graph_version","18.0")->set("client_id","")->set("client_secret","")
    ->set("scopes","")->set("endpoints","")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: social_auth_facebook.settings graph_version=18.0"
