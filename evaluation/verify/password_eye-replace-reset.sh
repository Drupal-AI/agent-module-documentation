#!/usr/bin/env bash
# Execution RESET for "eye only on the comment form, not login": set target list to the default
# 'user_login_form', so verify FAILS until the agent replaces it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("password_eye.settings")
    ->set("password_eye.form_id_password", "user_login_form")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: form_id_password = user_login_form"
