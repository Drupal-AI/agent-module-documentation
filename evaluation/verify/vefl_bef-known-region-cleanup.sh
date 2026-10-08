#!/usr/bin/env bash
# Introspection CLEANUP: delete the vefl_bef_region view config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.vefl_bef_region")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vefl_bef_region removed"
