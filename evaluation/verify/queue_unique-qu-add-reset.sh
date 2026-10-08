#!/usr/bin/env bash
# Execution RESET: ensure the unique queue qu_task is empty so verify FAILS until the agent
# adds an item via the queue_unique backend.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $q = \Drupal::service("queue_unique.database")->get("qu_task"); $q->createQueue();
  \Drupal::database()->delete("queue_unique")->condition("name","qu_task")->execute();
' >/dev/null 2>&1
echo "reset: unique queue qu_task emptied"
