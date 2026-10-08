#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default target list (user_login_form). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("password_eye.settings")
    ->set("password_eye.form_id_password", "user_login_form")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: form_id_password restored to user_login_form"
