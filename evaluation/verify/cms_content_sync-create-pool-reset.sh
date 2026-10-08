#!/usr/bin/env bash
# Execution RESET: ensure the target Pool does NOT exist so verify fails on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cms_content_sync\Entity\Pool;
  if ($p = Pool::load("ccs_task_pool")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: pool ccs_task_pool absent"
