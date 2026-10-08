#!/usr/bin/env bash
# Execution RESET/CLEANUP: delete the dropsolid_purge.config object so verify FAILS on empty state
# and the site is left clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("dropsolid_purge.config")->delete();' >/dev/null 2>&1
echo "reset: dropsolid_purge.config removed"
