#!/usr/bin/env bash
# Execution RESET: clear the State key the agent must write, so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("migrate_conditions_task1");' >/dev/null 2>&1
echo "reset: state key migrate_conditions_task1 deleted"
