#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults (enable_notifications=true, away=120).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("private_message.settings")
    ->set("enable_notifications", TRUE)
    ->set("number_of_seconds_considered_away", 120)->save();
' >/dev/null 2>&1
echo "cleanup: private_message.settings restored to defaults"
