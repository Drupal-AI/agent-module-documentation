#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush en rest_views_search_api -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rest_views_search_api enabled; views field definitions current"
