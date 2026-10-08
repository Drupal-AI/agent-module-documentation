#!/usr/bin/env bash
# Execution RESET: force query_sort/query_highlight to shipped defaults so verify FAILS.
set -uo pipefail
cd /var/www/html
drush cset -y webprofiler.settings query_sort source >/dev/null 2>&1
drush cset -y webprofiler.settings query_highlight 5 >/dev/null 2>&1
echo "reset: query_sort=source, query_highlight=5"
