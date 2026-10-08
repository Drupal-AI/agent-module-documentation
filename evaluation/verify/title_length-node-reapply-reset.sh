#!/usr/bin/env bash
# Execution RESET (title_length): shrink the node title DB column back to core's original 255,
# creating the FAIL state that verify detects until the agent re-applies the length.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("node_title_length.node")->changeLength(255);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node_field_data.title shrunk to 255"
