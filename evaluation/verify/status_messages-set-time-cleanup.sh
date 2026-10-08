#!/usr/bin/env bash
# Execution CLEANUP: remove the status_messages config object (baseline: unset). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("status_messages.status_messages")->delete();' >/dev/null 2>&1
echo "cleanup: status_messages.status_messages removed (baseline)"
