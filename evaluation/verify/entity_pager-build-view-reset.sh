#!/usr/bin/env bash
# Execution RESET: delete the ep_task_view View if present, so verify FAILS on empty state
# until the agent builds a View that uses the Entity Pager (entity_pager) style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("ep_task_view");
  if ($view) { $view->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ep_task_view deleted"
