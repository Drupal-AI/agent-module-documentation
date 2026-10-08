#!/usr/bin/env bash
# Execution RESET: ensure the target Flow does NOT exist so verify fails on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cms_content_sync\Entity\Flow;
  if ($f = Flow::load("ccs_task_flow")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: flow ccs_task_flow absent"
