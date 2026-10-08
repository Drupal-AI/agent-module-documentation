#!/usr/bin/env bash
# Introspection CLEANUP (message_subscribe_email): restore shipped default flag_prefix = 'email'.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("message_subscribe_email.settings")->set("flag_prefix", "email")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: message_subscribe_email.settings flag_prefix restored to email"
