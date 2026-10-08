#!/usr/bin/env bash
# Execution VERIFY: PASS when the handy_cache_tags bundle tag for hct_task has been invalidated at
# least once (a row exists in the cachetags counter table). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
n=$(drush sqlq "SELECT COUNT(*) FROM cachetags WHERE tag='handy_cache_tags:node:hct_task'" 2>/dev/null | tr -dc '0-9')
if [ "${n:-0}" -ge 1 ]; then
  echo "PASS invalidated rows=$n"
  exit 0
else
  echo "FAIL handy_cache_tags:node:hct_task never invalidated (rows=${n:-0})"
  exit 1
fi
