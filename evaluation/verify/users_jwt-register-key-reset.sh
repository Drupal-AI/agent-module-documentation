#!/usr/bin/env bash
# Execution RESET: ensure key id "usersjwt_task" does NOT exist (so verify
# FAILS until the agent registers it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("users_jwt.key_repository")->deleteKey("usersjwt_task");
' >/dev/null 2>&1
echo "reset: usersjwt_task key absent"
