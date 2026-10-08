#!/usr/bin/env bash
# Execution RESET: seed google_analytics_reports.settings:metadata_last_time with a non-empty
# value so verify FAILS until the agent clears it (to force a fresh GA field re-import). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_analytics_reports.settings metadata_last_time 1650000000 -y >/dev/null 2>&1
echo "reset: metadata_last_time seeded to 1650000000"
