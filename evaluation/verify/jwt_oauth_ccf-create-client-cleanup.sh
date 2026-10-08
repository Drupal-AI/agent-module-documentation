#!/usr/bin/env bash
# Execution CLEANUP: remove the jwtccf_task_client credential created by the
# task. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("jwt_oauth_ccf.client_repository")->deleteClient("jwtccf_task_client");
' >/dev/null 2>&1
echo "cleanup: jwtccf_task_client removed"
