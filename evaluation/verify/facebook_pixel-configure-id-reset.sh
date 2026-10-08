#!/usr/bin/env bash
# Execution RESET: clear the pixel id and restore the shipped role-visibility defaults, so
# verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("facebook_pixel.settings")
    ->set("facebook_id", "")
    ->set("visibility.user_role_mode", "all_roles")
    ->set("visibility.user_role_roles", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: facebook_id cleared, user_role_mode=all_roles, no roles listed"
