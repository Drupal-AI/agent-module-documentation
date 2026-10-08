#!/usr/bin/env bash
# Execution CLEANUP: restore query_sort/query_highlight to shipped defaults.
set -uo pipefail
cd /var/www/html
drush cset -y webprofiler.settings query_sort source >/dev/null 2>&1
drush cset -y webprofiler.settings query_highlight 5 >/dev/null 2>&1
echo "cleanup: webprofiler query log settings restored to defaults"
