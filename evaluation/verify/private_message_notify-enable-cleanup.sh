#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults (both true). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("private_message.settings")
    ->set("enable_notifications", TRUE)
    ->set("notify_by_default", TRUE)->save();
' >/dev/null 2>&1
echo "cleanup: private_message.settings notify flags restored to defaults"
