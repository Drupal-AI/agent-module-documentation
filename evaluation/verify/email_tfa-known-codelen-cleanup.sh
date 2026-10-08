#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default security code length (4). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("email_tfa.settings")->set("security_code_length", 4)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: email_tfa.settings security_code_length restored to 4"
