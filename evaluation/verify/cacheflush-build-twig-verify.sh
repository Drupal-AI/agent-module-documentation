#!/usr/bin/env bash
# Execution VERIFY (cacheflush): PASS when a published preset titled 'cf_task_twig' exists whose data
# clears the Twig storage (option 'twig' / clearStorageCache twig). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
n=$(drush sqlq "SELECT COUNT(*) FROM cacheflush WHERE title='cf_task_twig' AND status=1 AND data LIKE '%twig%'" 2>/dev/null | tr -dc '0-9')
if [ -n "$n" ] && [ "$n" -ge 1 ]; then echo "PASS cf_task_twig published twig-clearing presets=$n"; exit 0; fi
echo "FAIL no published cf_task_twig preset clearing twig (count=${n:-0})"; exit 1
