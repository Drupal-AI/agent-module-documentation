#!/usr/bin/env bash
# Introspection CLEANUP: delete the migdev_known migration config. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("migrate_plus.migration.migdev_known")->delete();' >/dev/null 2>&1
echo "cleanup: migrate_plus.migration.migdev_known removed"
