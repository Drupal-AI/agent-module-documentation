#!/usr/bin/env bash
# Introspection SETUP: ensure Password Policy's change_password_route is the module's separate-form route
# (the value change_pwd_page sets on install). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("password_policy.settings")
    ->set("change_password_route", "change_pwd_page.change_password_form")->save();
' >/dev/null 2>&1
echo "setup: password_policy.settings.change_password_route = change_pwd_page.change_password_form"
