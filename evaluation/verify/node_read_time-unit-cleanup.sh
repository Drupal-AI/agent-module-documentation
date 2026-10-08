#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default unit_of_time=minute. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("node_read_time.settings")->set("reading_time.unit_of_time", "minute")->save();
' >/dev/null 2>&1
echo "cleanup: node_read_time.settings reading_time.unit_of_time restored to minute"
