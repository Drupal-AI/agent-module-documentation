#!/usr/bin/env bash
# Execution CLEANUP: remove the View "vmcf_task_sort" built during the task. Restores
# baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vmcf_task_sort")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views.view.vmcf_task_sort removed"
