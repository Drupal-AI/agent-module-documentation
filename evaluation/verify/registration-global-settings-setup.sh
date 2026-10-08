#!/usr/bin/env bash
# Introspection SETUP: set known values in the global registration.settings config object.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("registration.settings")
    ->set("queue_notifications", 25)
    ->set("html_email", TRUE)
    ->save();
' >/dev/null 2>&1
echo "setup: registration.settings queue_notifications=25 html_email=true"
