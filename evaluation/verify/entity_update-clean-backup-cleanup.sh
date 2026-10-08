#!/usr/bin/env bash
# Execution CLEANUP: make sure the entity_update backup table is empty again. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::database()->truncate("entity_update")->execute();' >/dev/null 2>&1
echo "cleanup: entity_update backup table emptied"
