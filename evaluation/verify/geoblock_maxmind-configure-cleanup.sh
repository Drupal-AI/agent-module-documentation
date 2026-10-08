#!/usr/bin/env bash
# Execution CLEANUP: restore geoblock_maxmind.settings download_url to empty. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("geoblock_maxmind.settings")->set("download_url", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: geoblock_maxmind.settings download_url restored to empty"
