#!/usr/bin/env bash
# Introspection CLEANUP: delete config_merge_filter_eval.data from snapshot and active. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("config.storage.snapshot")->delete("config_merge_filter_eval.data");
  \Drupal::service("config.storage")->delete("config_merge_filter_eval.data");
' >/dev/null 2>&1
echo "cleanup: config_merge_filter_eval.data removed from snapshot and active"
