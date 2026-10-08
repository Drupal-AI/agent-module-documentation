#!/usr/bin/env bash
# Introspection SETUP: set a known security code length on email_tfa.settings so an inspecting
# agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("email_tfa.settings")->set("security_code_length", 8)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: email_tfa.settings security_code_length=8"
