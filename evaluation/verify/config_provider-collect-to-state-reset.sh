#!/usr/bin/env bash
# Execution RESET: delete the state key the agent must populate, so verify FAILS on empty
# state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("config_provider_eval_node");' >/dev/null 2>&1
echo "reset: state key config_provider_eval_node deleted"
