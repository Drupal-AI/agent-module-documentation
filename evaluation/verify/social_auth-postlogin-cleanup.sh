#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped social_auth.settings defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("social_auth.settings")
    ->set("post_login", "/user")
    ->set("user_allowed", "register")
    ->save();
' >/dev/null 2>&1
echo "cleanup: social_auth.settings post_login=/user user_allowed=register (defaults)"
