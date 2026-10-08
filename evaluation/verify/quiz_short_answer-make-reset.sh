#!/usr/bin/env bash
# Execution RESET: ensure no short_answer question titled quiz_sa_task exists, so verify FAILS
# until the agent creates it. Leaves the site clean when run at the end. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"short_answer","title"=>"quiz_sa_task"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "reset: quiz_sa_task absent"
