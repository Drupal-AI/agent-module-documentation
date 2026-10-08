#!/usr/bin/env bash
# Ensure rest_views_geo is enabled (baseline for these docs).
set -uo pipefail
cd /var/www/html
drush en rest_views_geo -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rest_views_geo enabled"
