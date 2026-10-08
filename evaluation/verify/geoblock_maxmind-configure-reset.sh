#!/usr/bin/env bash
# Execution RESET: force geoblock_maxmind.settings download_url back to empty (shipped
# default) so verify FAILS until the agent sets the requested URL. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("geoblock_maxmind.settings")->set("download_url", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: geoblock_maxmind.settings download_url cleared"
