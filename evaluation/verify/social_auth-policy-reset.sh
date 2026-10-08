#!/usr/bin/env bash
# Execution RESET: force social_auth.settings back to shipped defaults (user_allowed=register,
# post_login=/user) so verify FAILS until the agent sets login-only + custom redirect.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("social_auth.settings")
    ->set("user_allowed", "register")
    ->set("post_login", "/user")
    ->save();
' >/dev/null 2>&1
echo "reset: social_auth.settings user_allowed=register post_login=/user"
