#!/usr/bin/env bash
# Execution RESET: delete state key config_provider_eval_user so verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("config_provider_eval_user");' >/dev/null 2>&1
echo "reset: state key config_provider_eval_user deleted"
