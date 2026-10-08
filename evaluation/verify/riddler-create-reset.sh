#!/usr/bin/env bash
# Execution RESET: ensure riddle ri_task does NOT exist (so verify FAILS until the agent creates it).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("riddle");
  if ($e = $s->load("ri_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: riddle ri_task absent"
