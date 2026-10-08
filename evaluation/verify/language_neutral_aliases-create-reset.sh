#!/usr/bin/env bash
# Execution RESET: ensure NO alias exists for /lna-task-source (verify fails until built).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("path_alias");
  foreach ($s->loadByProperties(["path" => "/lna-task-source"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: /lna-task-source alias absent"
