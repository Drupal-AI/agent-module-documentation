#!/usr/bin/env bash
# Execution RESET for "make new messages email-notify by default". Forces both flags OFF so
# verify FAILS until the agent enables them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("private_message.settings")
    ->set("enable_notifications", FALSE)
    ->set("notify_by_default", FALSE)->save();
' >/dev/null 2>&1
echo "reset: enable_notifications=false, notify_by_default=false"
