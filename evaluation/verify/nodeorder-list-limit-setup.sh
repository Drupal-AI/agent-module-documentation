#!/usr/bin/env bash
# Introspection SETUP: set nodeorder.settings entity_list_limit to a known distinctive value (27).
# Agent reads it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("nodeorder.config_manager")->updateConfigValues(["entity_list_limit" => 27]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: nodeorder.settings entity_list_limit = 27"
