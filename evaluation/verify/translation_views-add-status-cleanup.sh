#!/usr/bin/env bash
# Execution CLEANUP: delete view tv_task2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.tv_task2")->delete();' >/dev/null 2>&1
echo "cleanup: tv_task2 removed"
