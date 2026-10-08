#!/usr/bin/env bash
# Introspection CLEANUP: restore auto-block settings to shipped defaults (idle 3 months, no email). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("block_inactive_users.settings")
    ->set("block_inactive_users_idle_time", "3")
    ->set("block_inactive_users_send_email", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block_inactive_users.settings restored (idle_time=3, send_email=FALSE)"
