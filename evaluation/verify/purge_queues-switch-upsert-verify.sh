#!/usr/bin/env bash
# Execution VERIFY: PASS when active Purge queue is database_unique_upsert.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'print current(\Drupal::service("purge.queue")->getPluginsEnabled());' 2>/dev/null)
echo "active queue: $out"
[ "$out" = "database_unique_upsert" ] && { echo "PASS"; exit 0; } || { echo "FAIL (want database_unique_upsert)"; exit 1; }
