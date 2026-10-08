#!/usr/bin/env bash
# Execution VERIFY (cacheflush_entity): PASS when a cacheflush entity titled 'cfe_task' exists and is
# enabled (status=1). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
n=$(drush sqlq "SELECT COUNT(*) FROM cacheflush WHERE title='cfe_task' AND status=1" 2>/dev/null | tr -dc '0-9')
if [ -n "$n" ] && [ "$n" -ge 1 ]; then echo "PASS cfe_task entities=$n"; exit 0; fi
echo "FAIL no enabled cfe_task cacheflush entity (count=${n:-0})"; exit 1
