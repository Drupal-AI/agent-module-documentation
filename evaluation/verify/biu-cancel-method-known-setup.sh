#!/usr/bin/env bash
# Introspection SETUP: configure the bulk Cancel Users tool with a known method + idle time so an
# agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("block_inactive_users.settings_cancel_users")
    ->set("block_inactive_users_disable_account_method", "user_cancel_block")
    ->set("block_inactive_users_idle_time", "18")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: settings_cancel_users method=user_cancel_block, idle_time=18"
