#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default metadata_last_time = ''. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset google_analytics_reports.settings metadata_last_time '' -y >/dev/null 2>&1
echo "cleanup: metadata_last_time restored to ''"
