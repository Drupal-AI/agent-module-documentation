#!/usr/bin/env bash
# Introspection SETUP: configure Queue Mail to queue all User-module mails.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("queue_mail.settings")->set("queue_mail_keys","user_*")->save();' >/dev/null 2>&1
echo "setup: queue_mail_keys=user_*"
