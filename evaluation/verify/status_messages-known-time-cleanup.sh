#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline by removing the status_messages config object (the
# module ships no default, so 'unset' is the baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("status_messages.status_messages")->delete();' >/dev/null 2>&1
echo "cleanup: status_messages.status_messages removed (baseline: unset)"
