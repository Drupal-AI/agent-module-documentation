#!/usr/bin/env bash
# Execution CLEANUP: restore shipped social_auth.settings defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("social_auth.settings")
    ->set("user_allowed", "register")
    ->set("post_login", "/user")
    ->save();
' >/dev/null 2>&1
echo "cleanup: social_auth.settings restored (user_allowed=register post_login=/user)"
