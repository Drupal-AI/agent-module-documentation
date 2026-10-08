#!/usr/bin/env bash
# Execution RESET: point Password Policy at core user.pass so verify FAILS until the agent wires it to the
# change_pwd_page separate form. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("password_policy.settings")
    ->set("change_password_route", "user.pass")->save();
' >/dev/null 2>&1
echo "reset: change_password_route = user.pass"
