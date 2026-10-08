#!/usr/bin/env bash
# Execution CLEANUP: remove the namespaced action. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($a = \Drupal::entityTypeManager()->getStorage("action")->load("ccs_views_task_action")) { $a->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: action ccs_views_task_action removed"
