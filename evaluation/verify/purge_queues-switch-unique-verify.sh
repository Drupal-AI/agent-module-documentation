#!/usr/bin/env bash
# Execution VERIFY: PASS when active Purge queue is database_unique.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'print current(\Drupal::service("purge.queue")->getPluginsEnabled());' 2>/dev/null)
echo "active queue: $out"
[ "$out" = "database_unique" ] && { echo "PASS"; exit 0; } || { echo "FAIL (want database_unique)"; exit 1; }
