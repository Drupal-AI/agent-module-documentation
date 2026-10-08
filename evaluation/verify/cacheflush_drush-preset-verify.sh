#!/usr/bin/env bash
# Execution VERIFY (cacheflush_drush): PASS when a published (status=1) preset 'cfd_task' exists - the
# precondition for `drush cf <id>` to clear it. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
n=$(drush sqlq "SELECT COUNT(*) FROM cacheflush WHERE title='cfd_task' AND status=1" 2>/dev/null | tr -dc '0-9')
if [ -n "$n" ] && [ "$n" -ge 1 ]; then echo "PASS published cfd_task presets=$n"; exit 0; fi
echo "FAIL no published cfd_task preset (count=${n:-0})"; exit 1
