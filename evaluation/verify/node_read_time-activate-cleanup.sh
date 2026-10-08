#!/usr/bin/env bash
# Execution CLEANUP: deactivate reading time for the Article node type (restore baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("node_read_time.settings")->set("reading_time.container", [])->save();
' >/dev/null 2>&1
echo "cleanup: node_read_time reading_time.container.article.is_activated=0"
