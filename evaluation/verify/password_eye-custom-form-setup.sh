#!/usr/bin/env bash
# Introspection SETUP: add a distinctive form id 'pe_custom_form' to password_eye's target list
# so an agent can read back which forms get the eye icon. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("password_eye.settings")
    ->set("password_eye.form_id_password", "user_login_form,pe_custom_form")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: form_id_password = user_login_form,pe_custom_form"
