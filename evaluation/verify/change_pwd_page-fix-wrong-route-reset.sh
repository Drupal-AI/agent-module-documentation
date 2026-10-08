#!/usr/bin/env bash
# Execution RESET: set change_password_route to the redirect route (wrong choice) so verify FAILS until the
# agent picks the form route. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("password_policy.settings")
    ->set("change_password_route", "change_pwd_page.change_password")->save();
' >/dev/null 2>&1
echo "reset: change_password_route = change_pwd_page.change_password (redirect route)"
