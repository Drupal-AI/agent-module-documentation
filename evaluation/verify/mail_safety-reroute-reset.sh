#!/usr/bin/env bash
# Execution RESET: clear reroute config so verify FAILS until the agent sets it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("mail_safety.settings")
    ->set("enabled", FALSE)
    ->set("send_mail_to_default_mail", FALSE)
    ->set("default_mail_address", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mail_safety reroute cleared"
