#!/usr/bin/env bash
# Execution VERIFY (cacheflush_advanced): PASS when a published preset 'cfa_task' exists whose data
# invalidates the 'node_list' cache tag (clearCacheTags). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
n=$(drush sqlq "SELECT COUNT(*) FROM cacheflush WHERE title='cfa_task' AND status=1 AND data LIKE '%clearCacheTags%' AND data LIKE '%node_list%'" 2>/dev/null | tr -dc '0-9')
if [ -n "$n" ] && [ "$n" -ge 1 ]; then echo "PASS cfa_task node_list-tag presets=$n"; exit 0; fi
echo "FAIL no cfa_task preset invalidating node_list tag (count=${n:-0})"; exit 1
