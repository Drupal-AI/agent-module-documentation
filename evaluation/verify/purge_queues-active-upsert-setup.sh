#!/usr/bin/env bash
# Introspection SETUP: set Purge active queue to database_unique_upsert.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("purge.queue")->setPluginsEnabled(["database_unique_upsert"]);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: purge.plugins queue = database_unique_upsert"
