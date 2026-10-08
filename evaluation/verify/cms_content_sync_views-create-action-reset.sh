#!/usr/bin/env bash
# Execution RESET: ensure the namespaced action is absent so verify fails on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($a = \Drupal::entityTypeManager()->getStorage("action")->load("ccs_views_task_action")) { $a->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: action ccs_views_task_action absent"
