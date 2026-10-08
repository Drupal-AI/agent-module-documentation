#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default 225 wpm. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("node_read_time.settings")->set("reading_time.words_per_minute", 225)->save();
' >/dev/null 2>&1
echo "cleanup: node_read_time.settings reading_time.words_per_minute restored to 225"
