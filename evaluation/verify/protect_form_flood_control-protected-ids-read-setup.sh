#!/usr/bin/env bash
# Introspection SETUP: protect a specific form ID (user_register_form), protect_all off. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("protect_form_flood_control.settings");
  $c->set("general.protect_all", FALSE)->set("general.protected_ids", ["user_register_form"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: protect_form_flood_control general.protected_ids=[user_register_form]"
