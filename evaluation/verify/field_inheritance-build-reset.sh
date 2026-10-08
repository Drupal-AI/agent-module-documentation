#!/usr/bin/env bash
# Execution RESET: delete any field_inheritance entity whose id contains 'fi_task' so verify FAILS
# until the agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field_inheritance\Entity\FieldInheritance;
  foreach (FieldInheritance::loadMultiple() as $e) {
    if (strpos($e->id(), "fi_task") !== FALSE) { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no field_inheritance entity matching fi_task"
