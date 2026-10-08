#!/usr/bin/env bash
# Introspection SETUP (message_subscribe): set a known distinctive subscription flag prefix
# ('follow') so an agent can read back which prefix identifies subscription flags. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("message_subscribe.settings")->set("flag_prefix", "follow")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: message_subscribe.settings flag_prefix = follow"
