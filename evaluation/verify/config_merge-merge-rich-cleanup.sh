#!/usr/bin/env bash
# Execution CLEANUP: delete both state keys. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::state()->delete("config_merge_eval_h1");
  \Drupal::state()->delete("config_merge_eval_h1_result");
' >/dev/null 2>&1
echo "cleanup: config_merge_eval_h1 keys deleted"
