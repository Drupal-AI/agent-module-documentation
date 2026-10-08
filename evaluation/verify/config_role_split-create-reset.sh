#!/usr/bin/env bash
# Execution RESET: ensure role_split crs_task does NOT exist so verify fails until built. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("role_split"); if($e=$s->load("crs_task")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role_split crs_task absent"
