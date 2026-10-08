#!/usr/bin/env bash
# Execution RESET: make sure the Key entity the agent must build does not exist yet.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($k = \Drupal::entityTypeManager()->getStorage("key")->load("ps_task_key")) { $k->delete(); }
' >/dev/null 2>&1
echo "reset: key ps_task_key absent"
