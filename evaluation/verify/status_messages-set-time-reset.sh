#!/usr/bin/env bash
# Execution RESET: remove the status_messages config object so status_message_time is unset and
# verify (expecting 10000) FAILS until the agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("status_messages.status_messages")->delete();' >/dev/null 2>&1
echo "reset: status_messages.status_messages removed (status_message_time unset)"
