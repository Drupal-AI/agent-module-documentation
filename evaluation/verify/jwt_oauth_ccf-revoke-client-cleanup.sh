#!/usr/bin/env bash
# Execution CLEANUP: ensure jwtccf_del_client is deleted regardless of whether
# the task succeeded. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("jwt_oauth_ccf.client_repository")->deleteClient("jwtccf_del_client");
' >/dev/null 2>&1
echo "cleanup: jwtccf_del_client removed"
