#!/usr/bin/env bash
# Execution CLEANUP: remove the state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("config_provider_eval_node");' >/dev/null 2>&1
echo "cleanup: state key config_provider_eval_node deleted"
