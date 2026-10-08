#!/usr/bin/env bash
# Introspection SETUP: set a known post-login redirect path and login-only mode in
# social_auth.settings so an agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("social_auth.settings")
    ->set("post_login", "/user/welcome-back")
    ->set("user_allowed", "login")
    ->save();
' >/dev/null 2>&1
echo "setup: social_auth.settings post_login=/user/welcome-back user_allowed=login"
