#!/usr/bin/env bash
# Execution RESET: ensure no quiz titled quiz_task exists, so verify FAILS until the agent
# creates it. Also leaves the site clean when run at the end. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("quiz")->loadByProperties(["title"=>"quiz_task"]) as $q) { $q->delete(); }
' >/dev/null 2>&1
echo "reset: quiz_task absent"
