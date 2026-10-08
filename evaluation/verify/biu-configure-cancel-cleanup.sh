#!/usr/bin/env bash
# Execution CLEANUP: restore Cancel Users settings to shipped defaults. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("block_inactive_users.settings_cancel_users")
    ->set("block_inactive_users_idle_time", "0")
    ->set("block_inactive_users_disable_account_method", "user_cancel_delete")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: settings_cancel_users restored to defaults"
