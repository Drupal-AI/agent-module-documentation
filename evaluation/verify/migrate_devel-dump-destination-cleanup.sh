#!/usr/bin/env bash
# Execution CLEANUP: delete the migdev_dump migration config. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("migrate_plus.migration.migdev_dump")->delete();' >/dev/null 2>&1
echo "cleanup: migrate_plus.migration.migdev_dump removed"
