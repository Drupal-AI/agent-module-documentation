#!/usr/bin/env bash
# Reset the "create a date_recur interpreter" execution task to a clean slate.
# Removes the date_recur_interpreter config entity the task creates (id eval_interpreter).
# Does NOT touch the shipped default_interpreter. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal\date_recur\Entity\DateRecurInterpreter::load("eval_interpreter")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: date_recur_interpreter eval_interpreter removed"
