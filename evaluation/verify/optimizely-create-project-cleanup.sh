#!/usr/bin/env bash
# Execution CLEANUP: delete any project the agent created with code 777000, plus optimizely_task.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("optimizely");
  foreach ($s->loadMultiple() as $p) {
    if ($p->id() !== "default" && ((int) $p->getCode() === 777000 || $p->id() === "optimizely_task")) { $p->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed agent-created code=777000 / optimizely_task projects"
