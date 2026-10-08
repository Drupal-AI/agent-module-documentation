#!/usr/bin/env bash
# Execution VERIFY: PASS when google_analytics_reports.settings:metadata_last_time is empty ''
# (import timestamp cleared). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val=$(drush cget google_analytics_reports.settings metadata_last_time --format=string 2>/dev/null | tr -d '[:space:]')
echo "metadata_last_time=[$val]"
[ -z "$val" ] && exit 0 || exit 1
