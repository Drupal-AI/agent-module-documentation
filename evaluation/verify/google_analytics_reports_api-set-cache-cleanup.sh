#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default cache_length = 259200. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_analytics_reports_api.settings cache_length 259200 -y >/dev/null 2>&1
echo "cleanup: cache_length restored to 259200"
