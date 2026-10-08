#!/usr/bin/env bash
# Execution VERIFY: PASS when google_analytics_reports_api.settings:property === '123456789'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val=$(drush cget google_analytics_reports_api.settings property --format=string 2>/dev/null | tr -d '[:space:]')
echo "property=$val"
[ "$val" = "123456789" ] && exit 0 || exit 1
