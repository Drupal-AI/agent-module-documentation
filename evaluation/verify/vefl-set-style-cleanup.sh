#!/usr/bin/env bash
# Execution CLEANUP: delete the vefl_task view config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.vefl_task")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vefl_task removed"
