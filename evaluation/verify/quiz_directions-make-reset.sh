#!/usr/bin/env bash
# Execution RESET: ensure no 'directions' question titled quiz_dir_task exists, so verify
# FAILS until the agent creates it. Leaves the site clean when run at the end. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"directions","title"=>"quiz_dir_task"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "reset: quiz_dir_task absent"
