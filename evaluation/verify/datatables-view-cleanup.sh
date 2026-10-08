#!/usr/bin/env bash
# Introspection CLEANUP: delete the dt_known view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.dt_known")->delete();' >/dev/null 2>&1
echo "cleanup: view dt_known removed"
