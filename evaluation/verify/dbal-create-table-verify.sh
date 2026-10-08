#!/usr/bin/env bash
# Execution VERIFY: PASS when table dbal_task exists and contains a row with id=1.
# (Checked with Drupal's own DB connection, independent of dbal.) exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
n=$(drush sql:query "SELECT COUNT(*) FROM dbal_task WHERE id = 1" 2>/dev/null | tr -dc '0-9')
if [ -n "$n" ] && [ "$n" -ge 1 ] 2>/dev/null; then
  echo "PASS dbal_task rows_with_id1=$n"; exit 0
else
  echo "FAIL dbal_task missing or no row id=1 (got '$n')"; exit 1
fi
