#!/usr/bin/env bash
# Introspection CLEANUP: remove the saved import config. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user_csv_import.importconfig")->delete();' >/dev/null 2>&1
echo "cleanup: user_csv_import.importconfig removed"
