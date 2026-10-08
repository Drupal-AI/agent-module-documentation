#!/usr/bin/env bash
# Introspection SETUP: set the reading rate to a known 300 wpm so the agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("node_read_time.settings")->set("reading_time.words_per_minute", 300)->save();
' >/dev/null 2>&1
echo "setup: node_read_time.settings reading_time.words_per_minute=300"
