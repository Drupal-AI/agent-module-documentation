#!/usr/bin/env bash
# Execution CLEANUP: remove the usersjwt_task key created by the task.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("users_jwt.key_repository")->deleteKey("usersjwt_task");
' >/dev/null 2>&1
echo "cleanup: usersjwt_task key removed"
