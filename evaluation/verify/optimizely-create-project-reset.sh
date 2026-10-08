#!/usr/bin/env bash
# Execution RESET: delete the optimizely_task project so verify FAILS until the agent creates it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("optimizely");
  if ($p = $s->load("optimizely_task")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: optimizely_task project absent"
