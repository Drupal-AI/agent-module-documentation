#!/usr/bin/env bash
# Execution VERIFY (entity_delete_log): PASS when a deletion-log row exists for a node titled
# 'edl_task_node'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
n=$(drush sqlq "SELECT COUNT(*) FROM entity_delete_log WHERE entity_type='node' AND entity_title='edl_task_node'" 2>/dev/null | tr -dc '0-9')
if [ -n "$n" ] && [ "$n" -ge 1 ]; then
  echo "PASS entity_delete_log rows for edl_task_node = $n"; exit 0
fi
echo "FAIL no entity_delete_log row for edl_task_node (count=${n:-0})"; exit 1
