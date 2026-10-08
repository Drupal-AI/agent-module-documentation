#!/usr/bin/env bash
# Introspection SETUP: set google_analytics_reports.settings:metadata_last_time to a known unix
# timestamp so an agent can read back when GA fields were last imported. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_analytics_reports.settings metadata_last_time 1700000000 -y >/dev/null 2>&1
echo "setup: metadata_last_time=1700000000"
