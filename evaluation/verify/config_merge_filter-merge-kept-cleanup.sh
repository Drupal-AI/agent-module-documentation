#!/usr/bin/env bash
# Execution CLEANUP: remove config_merge_filter_eval.item from snapshot+active and the state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("config.storage.snapshot")->delete("config_merge_filter_eval.item");
  \Drupal::service("config.storage")->delete("config_merge_filter_eval.item");
  \Drupal::state()->delete("config_merge_filter_eval_kept");
' >/dev/null 2>&1
echo "cleanup: config_merge_filter_eval.item and state key removed"
