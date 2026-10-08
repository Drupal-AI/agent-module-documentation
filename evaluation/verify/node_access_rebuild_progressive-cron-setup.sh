#!/usr/bin/env bash
# Introspection SETUP: enable cron-based progressive rebuild. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset node_access_rebuild_progressive.settings cron true -y >/dev/null 2>&1
drush cset node_access_rebuild_progressive.settings chunk 500 -y >/dev/null 2>&1
echo "setup: cron=true chunk=500"
