#!/usr/bin/env bash
# Execution RESET: ensure OAuth client "jwtccf_task_client" does NOT exist (so
# verify FAILS until the agent creates it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("jwt_oauth_ccf.client_repository")->deleteClient("jwtccf_task_client");
' >/dev/null 2>&1
echo "reset: jwtccf_task_client absent"
