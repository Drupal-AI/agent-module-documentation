#!/usr/bin/env bash
# Introspection CLEANUP (message_subscribe): restore shipped default flag_prefix = 'subscribe'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("message_subscribe.settings")->set("flag_prefix", "subscribe")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: message_subscribe.settings flag_prefix restored to subscribe"
