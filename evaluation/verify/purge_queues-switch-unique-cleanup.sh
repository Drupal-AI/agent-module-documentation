#!/usr/bin/env bash
# Execution CLEANUP: restore Purge active queue to core 'database'.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("purge.queue")->setPluginsEnabled(["database"]);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: purge.plugins queue restored to database"
