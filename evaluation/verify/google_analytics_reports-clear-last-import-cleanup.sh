#!/usr/bin/env bash
# Execution CLEANUP: leave shipped default metadata_last_time = '' (empty). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_analytics_reports.settings metadata_last_time '' -y >/dev/null 2>&1
echo "cleanup: metadata_last_time = ''"
