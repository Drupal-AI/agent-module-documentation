#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("queue_mail.settings")->set("queue_mail_keys","")->save();' >/dev/null 2>&1
echo "cleanup: queue_mail_keys cleared"
