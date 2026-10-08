#!/usr/bin/env bash
# Execution CLEANUP: remove the Key entity built during the case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($k = \Drupal::entityTypeManager()->getStorage("key")->load("ps_task_key")) { $k->delete(); }
' >/dev/null 2>&1
echo "cleanup: key ps_task_key removed"
