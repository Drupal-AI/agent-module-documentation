#!/usr/bin/env bash
# Introspection CLEANUP: delete both config objects. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_delete_dep.settings")->delete();
  \Drupal::configFactory()->getEditable("config_delete_child.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: config_delete_dep.settings and config_delete_child.settings removed"
