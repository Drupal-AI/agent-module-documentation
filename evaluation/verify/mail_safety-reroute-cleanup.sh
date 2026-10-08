#!/usr/bin/env bash
# Introspection CLEANUP: restore mail_safety.settings shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("mail_safety.settings")
    ->set("enabled", FALSE)
    ->set("send_mail_to_dashboard", FALSE)
    ->set("send_mail_to_default_mail", FALSE)
    ->set("default_mail_address", "")
    ->set("log_retention_period", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mail_safety.settings restored to defaults"
