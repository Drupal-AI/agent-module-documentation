#!/usr/bin/env bash
# Execution CLEANUP: restore the module's install baseline for the route. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("password_policy.settings")
    ->set("change_password_route", "change_pwd_page.change_password_form")->save();
' >/dev/null 2>&1
echo "cleanup: change_password_route restored to change_pwd_page.change_password_form"
