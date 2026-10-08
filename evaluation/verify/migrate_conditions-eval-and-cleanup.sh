#!/usr/bin/env bash
# Execution CLEANUP: remove the State key (leave the site clean).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("migrate_conditions_task2");' >/dev/null 2>&1
echo "cleanup: state key migrate_conditions_task2 deleted"
