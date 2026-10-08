#!/usr/bin/env bash
# Execution CLEANUP: remove the task pool. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cms_content_sync\Entity\Pool;
  if ($p = Pool::load("ccs_task_pool")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pool ccs_task_pool removed"
