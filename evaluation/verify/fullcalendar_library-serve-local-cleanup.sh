#!/usr/bin/env bash
# Execution CLEANUP: remove any local FullCalendar files the agent created, restoring the
# CDN-fallback baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/fullcalendar web/libraries/fullcalendar-scheduler
drush cr >/dev/null 2>&1
echo "cleanup: local FullCalendar files removed (back to CDN fallback)"
