#!/usr/bin/env bash
# Execution RESET: force words_per_minute back to the default 225 so verify FAILS until the
# agent sets 150. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("node_read_time.settings")->set("reading_time.words_per_minute", 225)->save();
' >/dev/null 2>&1
echo "reset: node_read_time reading_time.words_per_minute=225"
