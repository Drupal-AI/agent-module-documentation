#!/usr/bin/env bash
# Introspection SETUP: save an import config whose registration email is the admin-created
# welcome email. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("user_csv_import.importconfig")
    ->set("password", "change me")
    ->set("status", "1")
    ->set("roles", ["authenticated"=>"authenticated"])
    ->set("registration_email_type", "register_admin_created")
    ->set("config_fields", ["name"=>"name","mail"=>"mail","timezone"=>"timezone"])
    ->save();
' >/dev/null 2>&1
echo "setup: importconfig registration_email_type=register_admin_created"
