#!/usr/bin/env bash
# Execution RESET: empty the qu_dup unique queue so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $q = \Drupal::service("queue_unique.database")->get("qu_dup"); $q->createQueue();
  \Drupal::database()->delete("queue_unique")->condition("name","qu_dup")->execute();
' >/dev/null 2>&1
echo "reset: qu_dup emptied"
