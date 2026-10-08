#!/usr/bin/env bash
# Execution CLEANUP: restore the Persistent Login install defaults after the case.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("persistent_login.settings")
    ->set("lifetime", 30)
    ->set("extend_lifetime", FALSE)
    ->set("max_tokens", 0)
    ->set("login_form.field_label", "Remember me")
    ->set("cookie_prefix", "PL")
    ->save();
' >/dev/null 2>&1
echo "cleanup: persistent_login.settings restored to install defaults (30/false/0/'Remember me'/PL)"
