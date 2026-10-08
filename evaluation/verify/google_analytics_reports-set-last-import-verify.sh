#!/usr/bin/env bash
# Execution VERIFY: PASS when google_analytics_reports.settings:metadata_last_time === '1699999999'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val=$(drush cget google_analytics_reports.settings metadata_last_time --format=string 2>/dev/null | tr -d '[:space:]')
echo "metadata_last_time=$val"
[ "$val" = "1699999999" ] && exit 0 || exit 1
