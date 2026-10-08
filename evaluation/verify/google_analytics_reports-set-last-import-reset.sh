#!/usr/bin/env bash
# Execution RESET: clear google_analytics_reports.settings:metadata_last_time to '' so verify
# FAILS until the agent sets the requested timestamp. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_analytics_reports.settings metadata_last_time '' -y >/dev/null 2>&1
echo "reset: metadata_last_time cleared to ''"
