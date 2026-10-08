#!/usr/bin/env bash
# Introspection SETUP: set google_analytics_reports_api.settings:cache_length to a known
# non-default value (86400 = 1 day) so an agent can read back the query cache length. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_analytics_reports_api.settings cache_length 86400 -y >/dev/null 2>&1
echo "setup: cache_length=86400"
