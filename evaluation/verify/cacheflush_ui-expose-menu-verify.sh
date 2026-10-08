#!/usr/bin/env bash
# Execution VERIFY (cacheflush_ui): PASS when preset 'cfu_task' is published and exposed in the admin
# menu (menu=1). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
n=$(drush sqlq "SELECT COUNT(*) FROM cacheflush WHERE title='cfu_task' AND status=1 AND menu=1" 2>/dev/null | tr -dc '0-9')
if [ -n "$n" ] && [ "$n" -ge 1 ]; then echo "PASS cfu_task menu-exposed presets=$n"; exit 0; fi
echo "FAIL cfu_task not exposed in admin menu (count=${n:-0})"; exit 1
