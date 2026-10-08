#!/usr/bin/env bash
# Introspection SETUP: disable Cookiebot for the anonymous role and enable IAB. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cookiebot.settings")
    ->set("disabled_for_roles", ["anonymous"])
    ->set("cookiebot_iab_enabled", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: disabled_for_roles=[anonymous] cookiebot_iab_enabled=TRUE"
