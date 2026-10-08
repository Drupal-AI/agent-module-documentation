#!/usr/bin/env bash
# Introspection SETUP: seed a distinct known value (user.pass) into Password Policy's change_password_route
# so the agent must read the live config to answer. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("password_policy.settings")
    ->set("change_password_route", "user.pass")->save();
' >/dev/null 2>&1
echo "setup: password_policy.settings.change_password_route = user.pass"
