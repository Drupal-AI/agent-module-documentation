#!/usr/bin/env bash
# Execution CLEANUP: restore auto-block settings to shipped defaults. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("block_inactive_users.settings")
    ->set("block_inactive_users_idle_time", "3")
    ->set("block_inactive_users_send_email", FALSE)
    ->set("block_inactive_users_email_subject", "User disabled.")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block_inactive_users.settings restored to defaults"
