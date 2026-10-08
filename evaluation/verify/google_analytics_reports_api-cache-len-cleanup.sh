#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default cache_length = 259200 (3 days). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_analytics_reports_api.settings cache_length 259200 -y >/dev/null 2>&1
echo "cleanup: cache_length restored to 259200"
