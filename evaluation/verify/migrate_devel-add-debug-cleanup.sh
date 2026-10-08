#!/usr/bin/env bash
# Execution CLEANUP: delete the migdev_task migration config. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("migrate_plus.migration.migdev_task")->delete();' >/dev/null 2>&1
echo "cleanup: migrate_plus.migration.migdev_task removed"
