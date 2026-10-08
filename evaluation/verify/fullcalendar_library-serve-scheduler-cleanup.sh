#!/usr/bin/env bash
# Execution CLEANUP: remove any local FullCalendar/Scheduler files, restoring the CDN baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/fullcalendar web/libraries/fullcalendar-scheduler
drush cr >/dev/null 2>&1
echo "cleanup: local FullCalendar/Scheduler files removed (back to CDN fallback)"
