#!/usr/bin/env bash
# Introspection CLEANUP: restore statistics.settings:count_content_views to its install
# default of 0 (counting OFF), undoing the matching setup script. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset statistics.settings count_content_views 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: statistics.settings count_content_views = 0 (baseline)"
