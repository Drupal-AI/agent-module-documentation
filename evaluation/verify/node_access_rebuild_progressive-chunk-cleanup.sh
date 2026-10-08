#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (chunk=500, cron=false). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset node_access_rebuild_progressive.settings chunk 500 -y >/dev/null 2>&1
drush cset node_access_rebuild_progressive.settings cron false -y >/dev/null 2>&1
echo "cleanup: chunk=500 cron=false (defaults)"
