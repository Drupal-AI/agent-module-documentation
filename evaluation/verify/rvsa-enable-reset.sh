#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush pmu rest_views_search_api -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: rest_views_search_api uninstalled"
