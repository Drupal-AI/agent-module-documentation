#!/usr/bin/env bash
# Execution CLEANUP: ensure both config objects are gone. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_delete_parent.settings")->delete();
  \Drupal::configFactory()->getEditable("config_delete_dchild.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: config_delete_parent.settings and config_delete_dchild.settings removed"
