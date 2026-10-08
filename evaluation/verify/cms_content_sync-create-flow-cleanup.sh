#!/usr/bin/env bash
# Execution CLEANUP: remove the task flow. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cms_content_sync\Entity\Flow;
  if ($f = Flow::load("ccs_task_flow")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: flow ccs_task_flow removed"
