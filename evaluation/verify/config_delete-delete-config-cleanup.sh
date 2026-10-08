#!/usr/bin/env bash
# Execution CLEANUP: ensure config_delete_task.settings is gone. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_delete_task.settings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: config_delete_task.settings removed"
