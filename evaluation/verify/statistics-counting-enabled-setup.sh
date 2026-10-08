#!/usr/bin/env bash
# Introspection SETUP: put the Statistics module into a KNOWN state where content-view
# counting is switched ON, so an inspecting agent can read it back from config. Sets
# statistics.settings:count_content_views = 1. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset statistics.settings count_content_views 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: statistics.settings count_content_views = 1 (counting ON)"
