#!/usr/bin/env bash
# Introspection SETUP: create social_auth_facebook.settings with a distinctive Facebook App ID
# (client_id) so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("social_auth_facebook.settings")
    ->set("client_id","fb_probe_appid_9988")->set("client_secret","")->set("graph_version","17.0")
    ->set("scopes","")->set("endpoints","")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: social_auth_facebook.settings client_id=fb_probe_appid_9988"
