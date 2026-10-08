#!/usr/bin/env bash
# Execution RESET: force Mail Safety OFF (enabled + dashboard capture false) so verify
# FAILS until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("mail_safety.settings")
    ->set("enabled", FALSE)
    ->set("send_mail_to_dashboard", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mail_safety enabled=false, send_mail_to_dashboard=false"
