#!/usr/bin/env bash
# Introspection SETUP: place local FullCalendar library files under the web root so the
# module's hook_library_info_alter keeps the LOCAL asset paths instead of the CDN fallback.
# An inspecting agent should then be able to report that fullcalendar.min.js is served
# locally. DRUPAL_ROOT is the web dir. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
mkdir -p web/libraries/fullcalendar/lib web/libraries/fullcalendar-scheduler
for f in web/libraries/fullcalendar/fullcalendar.min.js \
         web/libraries/fullcalendar/fullcalendar.min.css \
         web/libraries/fullcalendar/fullcalendar.print.min.css \
         web/libraries/fullcalendar/locale-all.js \
         web/libraries/fullcalendar/lib/moment.min.js \
         web/libraries/fullcalendar-scheduler/scheduler.min.js \
         web/libraries/fullcalendar-scheduler/scheduler.min.css; do
  printf '/* fullcalendar_library eval fixture */\n' > "$f"
done
drush cr >/dev/null 2>&1
echo "setup: local FullCalendar files created under web/libraries/fullcalendar(-scheduler)"
