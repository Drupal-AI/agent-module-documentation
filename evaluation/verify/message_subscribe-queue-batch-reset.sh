#!/usr/bin/env bash
# Execution RESET (message_subscribe): restore shipped defaults use_queue=false, range=100 so verify
# FAILS until the agent enables queueing and sets the batch cap. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("message_subscribe.settings")->set("use_queue", FALSE)->set("range", 100)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: message_subscribe.settings use_queue=false, range=100"
