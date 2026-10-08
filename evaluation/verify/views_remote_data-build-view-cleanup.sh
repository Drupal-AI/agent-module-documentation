#!/usr/bin/env bash
# Execution CLEANUP: delete the vrd_build view.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.vrd_build")->delete();' >/dev/null 2>&1
echo "cleanup: view vrd_build deleted"
