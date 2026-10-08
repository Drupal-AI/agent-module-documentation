#!/usr/bin/env bash
# Execution CLEANUP: delete the vrd_cache view.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.vrd_cache")->delete();' >/dev/null 2>&1
echo "cleanup: view vrd_cache deleted"
