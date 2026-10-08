#!/usr/bin/env bash
# Execution CLEANUP: delete crs_mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("role_split"); if($e=$s->load("crs_mode")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role_split crs_mode removed"
