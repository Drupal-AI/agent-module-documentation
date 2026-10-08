#!/usr/bin/env bash
# Execution RESET: ensure NO local FullCalendar or Scheduler files exist, so the Scheduler
# add-on falls back to the jsDelivr CDN and verify FAILS until a local Scheduler copy exists.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf web/libraries/fullcalendar web/libraries/fullcalendar-scheduler
drush cr >/dev/null 2>&1
echo "reset: local FullCalendar/Scheduler files removed (CDN fallback active)"
