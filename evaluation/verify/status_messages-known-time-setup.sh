#!/usr/bin/env bash
# Introspection SETUP: set status_messages status_message_time to a known value (15000 ms =
# 15 seconds) so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("status_messages.status_messages")->set("status_message_time",15000)->save();' >/dev/null 2>&1
echo "setup: status_messages.status_messages status_message_time=15000 (15s)"
