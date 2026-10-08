#!/usr/bin/env bash
# Execution RESET: force Purge active queue to core 'database' so verify FAILS until agent switches to database_unique.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("purge.queue")->setPluginsEnabled(["database"]);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: purge.plugins queue = database (core default)"
