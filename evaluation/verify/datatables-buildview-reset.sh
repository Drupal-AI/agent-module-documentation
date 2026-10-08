#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure the dt_task view does NOT exist (verify FAILS on empty). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.dt_task")->delete();' >/dev/null 2>&1
echo "reset: view dt_task absent"
