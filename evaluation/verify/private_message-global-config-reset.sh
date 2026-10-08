#!/usr/bin/env bash
# Execution RESET for "disable notifications globally and set away threshold to 300".
# Forces the shipped baseline (enable_notifications=true, number_of_seconds_considered_away=120)
# so verify FAILS until the agent applies the change. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("private_message.settings")
    ->set("enable_notifications", TRUE)
    ->set("number_of_seconds_considered_away", 120)->save();
' >/dev/null 2>&1
echo "reset: enable_notifications=true, number_of_seconds_considered_away=120"
