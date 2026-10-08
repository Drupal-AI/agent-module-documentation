#!/usr/bin/env bash
# Introspection SETUP: set google_analytics_reports_api.settings:property to a known GA4 property
# id so an agent can read back which property is configured. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_analytics_reports_api.settings property 987654321 -y >/dev/null 2>&1
echo "setup: property=987654321"
