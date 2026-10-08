#!/usr/bin/env bash
# Execution RESET: force Mailgun use_queue OFF so verify FAILS until the agent enables queued sending. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("mailgun.settings")->set("use_queue", FALSE)->save();' >/dev/null 2>&1
echo "reset: mailgun.settings use_queue=false"
