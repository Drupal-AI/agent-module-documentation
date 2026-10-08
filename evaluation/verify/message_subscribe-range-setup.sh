#!/usr/bin/env bash
# Introspection SETUP (message_subscribe): set a known distinctive batch range (250) in
# message_subscribe.settings so an agent can read back the max subscribers per batch. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("message_subscribe.settings")->set("range", 250)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: message_subscribe.settings range = 250"
