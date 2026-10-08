#!/usr/bin/env bash
# Execution RESET: ensure no 'page' question titled quiz_pg_task exists, so verify FAILS until
# the agent creates it. Leaves the site clean when run at the end. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"page","title"=>"quiz_pg_task"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "reset: quiz_pg_task absent"
