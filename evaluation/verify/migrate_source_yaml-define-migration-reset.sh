#!/usr/bin/env bash
# Execution RESET/CLEANUP: delete the msy_task migration config so verify FAILS until the agent
# creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("migrate_plus.migration.msy_task")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: migration msy_task absent"
