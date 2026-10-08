#!/usr/bin/env bash
# Introspection SETUP: set the reading-time display format to minutes+seconds ('second'). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("node_read_time.settings")->set("reading_time.unit_of_time", "second")->save();
' >/dev/null 2>&1
echo "setup: node_read_time.settings reading_time.unit_of_time=second"
