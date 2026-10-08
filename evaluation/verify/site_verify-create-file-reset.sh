#!/usr/bin/env bash
# Execution RESET: ensure no sv_task_file site_verification entity exists (so verify FAILS
# until the agent creates it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("site_verification");
  if ($entity = $storage->load("sv_task_file")) {
    $entity->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: sv_task_file absent"
