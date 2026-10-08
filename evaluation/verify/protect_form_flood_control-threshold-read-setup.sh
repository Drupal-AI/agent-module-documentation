#!/usr/bin/env bash
# Introspection SETUP: change the default flood threshold to 7. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("protect_form_flood_control.settings");
  $c->set("general.threshold", 7)->set("general.window", 120)->set("general.protect_all", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: protect_form_flood_control general.threshold=7"
