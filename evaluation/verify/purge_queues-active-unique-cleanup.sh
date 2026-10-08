#!/usr/bin/env bash
# Introspection CLEANUP: restore Purge active queue to the shipped default (database).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("purge.queue")->setPluginsEnabled(["database"]);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: purge.plugins queue restored to database"
