#!/usr/bin/env bash
# Introspection CLEANUP: delete state key config_merge_eval_update. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("config_merge_eval_update");' >/dev/null 2>&1
echo "cleanup: state config_merge_eval_update deleted"
