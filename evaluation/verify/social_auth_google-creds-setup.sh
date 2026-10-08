#!/usr/bin/env bash
# Introspection SETUP: store a known Google client id + restricted domain. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("social_auth_google.settings")->set("client_id","eval-123.apps.googleusercontent.com")->set("restricted_domain","example.com")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: social_auth_google.settings client_id=eval-123... restricted_domain=example.com"
