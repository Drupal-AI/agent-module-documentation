#!/usr/bin/env bash
# Execution RESET for "add the eye to the registration form": set target list to the default
# 'user_login_form' only, so verify FAILS until the agent adds user_register_form. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("password_eye.settings")
    ->set("password_eye.form_id_password", "user_login_form")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: form_id_password = user_login_form"
