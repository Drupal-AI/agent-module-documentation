#!/usr/bin/env bash
# Execution RESET: force Cancel Users settings to shipped defaults so verify FAILS until the
# agent reconfigures them (idle 12, method user_cancel_block). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("block_inactive_users.settings_cancel_users")
    ->set("block_inactive_users_idle_time", "0")
    ->set("block_inactive_users_disable_account_method", "user_cancel_delete")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: settings_cancel_users at defaults (idle 0, method user_cancel_delete)"
