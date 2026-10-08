#!/usr/bin/env bash
# Introspection SETUP (message_subscribe_email): set a known distinctive email flag prefix ('notify')
# in message_subscribe_email.settings so an agent can read back which prefix marks email flags.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("message_subscribe_email.settings")->set("flag_prefix", "notify")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: message_subscribe_email.settings flag_prefix = notify"
