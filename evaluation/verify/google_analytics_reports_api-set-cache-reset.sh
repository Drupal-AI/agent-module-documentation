#!/usr/bin/env bash
# Execution RESET: force cache_length to the shipped default 259200 so verify FAILS until the
# agent changes it to the requested 604800. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_analytics_reports_api.settings cache_length 259200 -y >/dev/null 2>&1
echo "reset: cache_length=259200"
