#!/usr/bin/env bash
# Introspection CLEANUP (message_subscribe): restore shipped default range = 100. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("message_subscribe.settings")->set("range", 100)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: message_subscribe.settings range restored to 100"
