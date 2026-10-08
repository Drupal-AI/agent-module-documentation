#!/usr/bin/env bash
# Execution RESET: delete the vrd_build view so the verify FAILS until the agent creates it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.vrd_build")->delete();' >/dev/null 2>&1
echo "reset: view vrd_build deleted"
