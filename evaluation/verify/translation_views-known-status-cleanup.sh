#!/usr/bin/env bash
# Introspection CLEANUP: delete view tv_probe. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.tv_probe")->delete();' >/dev/null 2>&1
echo "cleanup: tv_probe removed"
