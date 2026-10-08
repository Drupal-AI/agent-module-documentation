#!/usr/bin/env bash
# Introspection SETUP: set a known chunk size (250) in node_access_rebuild_progressive.settings. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset node_access_rebuild_progressive.settings chunk 250 -y >/dev/null 2>&1
drush cset node_access_rebuild_progressive.settings cron false -y >/dev/null 2>&1
echo "setup: chunk=250 cron=false"
