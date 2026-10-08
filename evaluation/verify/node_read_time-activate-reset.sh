#!/usr/bin/env bash
# Execution RESET: force reading time OFF for the Article node type so verify FAILS until the
# agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("node_read_time.settings")->set("reading_time.container", [])->save();
' >/dev/null 2>&1
echo "reset: node_read_time reading_time.container.article.is_activated=0"
