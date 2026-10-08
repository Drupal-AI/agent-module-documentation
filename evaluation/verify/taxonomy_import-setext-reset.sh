#!/usr/bin/env bash
# Execution RESET: remove any taxonomy_import.config override so allowed extensions are back at
# the code default ('csv xml') and a "also allow txt" task fails until performed. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("taxonomy_import.config")->delete();' >/dev/null 2>&1
echo "reset: taxonomy_import.config cleared (file_extensions default 'csv xml')"
