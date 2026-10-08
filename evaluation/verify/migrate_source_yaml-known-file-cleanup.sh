#!/usr/bin/env bash
# Introspection CLEANUP: delete the msy_known migration config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("migrate_plus.migration.msy_known")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migration msy_known removed"
