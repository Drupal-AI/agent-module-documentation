#!/usr/bin/env bash
# Execution VERIFY: PASS when cache_length === 604800 (7 days). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val=$(drush cget google_analytics_reports_api.settings cache_length --format=string 2>/dev/null | tr -d '[:space:]')
echo "cache_length=$val"
[ "$val" = "604800" ] && exit 0 || exit 1
