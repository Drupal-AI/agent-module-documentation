#!/usr/bin/env bash
# Introspection SETUP: set password_eye to target ONLY 'pe_solo_form' (login removed), so an
# agent can read back the exact configured form id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("password_eye.settings")
    ->set("password_eye.form_id_password", "pe_solo_form")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: form_id_password = pe_solo_form"
