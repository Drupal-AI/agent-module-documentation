#!/usr/bin/env bash
# Execution CLEANUP: delete the ep_task_view View the agent created. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("ep_task_view");
  if ($view) { $view->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ep_task_view deleted"
