#!/usr/bin/env bash
# Introspection SETUP: save a known User CSV Import configuration (default password + roles +
# status). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("user_csv_import.importconfig")
    ->set("password", "UcsvKnownPw123")
    ->set("status", "1")
    ->set("roles", ["authenticated"=>"authenticated","content_editor"=>"content_editor"])
    ->set("registration_email_type", "none")
    ->set("config_fields", ["name"=>"name","mail"=>"mail"])
    ->save();
' >/dev/null 2>&1
echo "setup: user_csv_import.importconfig saved (password=UcsvKnownPw123)"
