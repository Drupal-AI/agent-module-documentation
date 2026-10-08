#!/usr/bin/env bash
# Introspection CLEANUP: delete state key config_merge_eval_keep. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("config_merge_eval_keep");' >/dev/null 2>&1
echo "cleanup: state config_merge_eval_keep deleted"
