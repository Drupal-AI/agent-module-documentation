#!/usr/bin/env bash
# Execution CLEANUP: same as reset. Idempotent. Exit 0.
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
echo "cleanup: facebook_pixel id and role visibility restored to install defaults"
