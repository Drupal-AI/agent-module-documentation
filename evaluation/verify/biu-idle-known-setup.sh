#!/usr/bin/env bash
# Introspection SETUP: set a known auto-block idle time (9 months) + email on, so an agent can
# read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("block_inactive_users.settings")
    ->set("block_inactive_users_idle_time", "9")
    ->set("block_inactive_users_send_email", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block_inactive_users.settings idle_time=9, send_email=TRUE"
