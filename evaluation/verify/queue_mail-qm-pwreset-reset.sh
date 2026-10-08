#!/usr/bin/env bash
# Execution RESET: clear queue_mail_keys so verify FAILS until the agent queues just the
# password reset mail id.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("queue_mail.settings")->set("queue_mail_keys","")->save();' >/dev/null 2>&1
echo "reset: queue_mail_keys cleared"
