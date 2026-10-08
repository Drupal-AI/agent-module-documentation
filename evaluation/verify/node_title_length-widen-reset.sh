#!/usr/bin/env bash
# Execution RESET (node_title_length): shrink node_field_data.title back to 255 so verify FAILS
# until the agent widens the node title column to 700. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("node_title_length.node")->changeLength(255);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node_field_data.title shrunk to 255"
