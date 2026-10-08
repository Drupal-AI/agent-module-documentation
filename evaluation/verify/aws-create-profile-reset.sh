#!/usr/bin/env bash
# Execution RESET: delete aws_task_profile so verify FAILS until the agent creates it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("aws_profile");
  if ($p = $s->load("aws_task_profile")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: aws_task_profile absent"
