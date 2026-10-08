#!/usr/bin/env bash
# Execution CLEANUP: restore nodeorder.settings entity_list_limit to the shipped default (50).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("nodeorder.config_manager")->updateConfigValues(["entity_list_limit" => 50]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: entity_list_limit restored to 50"
