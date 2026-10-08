#!/usr/bin/env bash
# Execution RESET: ensure no long_answer question titled quiz_la_task exists, so verify FAILS
# until the agent creates it. Leaves the site clean when run at the end. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"long_answer","title"=>"quiz_la_task"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "reset: quiz_la_task absent"
