#!/usr/bin/env bash
# Introspection CLEANUP: delete the migrate_plus.migration.mc_switch_test config entity created
# by the matching setup (restore baseline). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("migrate_plus.migration.mc_switch_test")->delete();' >/dev/null 2>&1
echo "cleanup: migrate_plus.migration.mc_switch_test removed"
