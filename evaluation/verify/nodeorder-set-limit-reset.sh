#!/usr/bin/env bash
# Execution RESET: set nodeorder.settings entity_list_limit to the shipped default (50) so verify
# (which expects 10) FAILS until the agent changes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("nodeorder.config_manager")->updateConfigValues(["entity_list_limit" => 50]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: nodeorder.settings entity_list_limit = 50"
