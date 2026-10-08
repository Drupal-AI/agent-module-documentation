#!/usr/bin/env bash
# Introspection CLEANUP: delete the vefl_known view config created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.vefl_known")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view vefl_known removed"
