#!/usr/bin/env bash
# Execution VERIFY (cacheflush): PASS when a published (status=1) cacheflush preset titled 'cf_task'
# exists whose stored data clears the render cache. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
n=$(drush sqlq "SELECT COUNT(*) FROM cacheflush WHERE title='cf_task' AND status=1 AND (data LIKE '%cache.render%' OR data LIKE '%\"render\"%')" 2>/dev/null | tr -dc '0-9')
if [ -n "$n" ] && [ "$n" -ge 1 ]; then echo "PASS cf_task published render-clearing presets=$n"; exit 0; fi
echo "FAIL no published cf_task preset clearing render (count=${n:-0})"; exit 1
