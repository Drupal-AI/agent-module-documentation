#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults for the touched registration.settings keys
# (defaults from config/install/registration.settings.yml). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("registration.settings")
    ->set("queue_notifications", 50)
    ->set("html_email", FALSE)
    ->save();
' >/dev/null 2>&1
echo "cleanup: registration.settings restored (queue_notifications=50 html_email=false)"
