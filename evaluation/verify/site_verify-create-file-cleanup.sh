#!/usr/bin/env bash
# Execution CLEANUP: remove the sv_task_file entity the agent created (and rebuild routes
# so its file route is dropped too). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("site_verification");
  if ($entity = $storage->load("sv_task_file")) {
    $entity->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sv_task_file removed"
