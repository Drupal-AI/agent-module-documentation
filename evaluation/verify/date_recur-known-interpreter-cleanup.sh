#!/usr/bin/env bash
# Introspection CLEANUP: remove the known date_recur_interpreter config entity
# (id eval_intro_interpreter), restoring baseline. Never touches default_interpreter.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal\date_recur\Entity\DateRecurInterpreter::load("eval_intro_interpreter")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: date_recur_interpreter eval_intro_interpreter removed"
