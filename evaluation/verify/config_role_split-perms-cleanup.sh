#!/usr/bin/env bash
# Introspection CLEANUP: delete crs_perms. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$s=\Drupal::entityTypeManager()->getStorage("role_split"); if($e=$s->load("crs_perms")){$e->delete();}' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role_split crs_perms removed"
