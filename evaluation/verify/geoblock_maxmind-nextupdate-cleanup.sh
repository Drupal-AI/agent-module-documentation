#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("geoblock_maxmind.update_date");' >/dev/null 2>&1
echo "cleanup: State geoblock_maxmind.update_date deleted"
