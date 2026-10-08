#!/usr/bin/env bash
# Execution CLEANUP (title_length): ensure the node title column is at the module default 500.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("node_title_length.node")->changeLength(500);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node_field_data.title set to 500"
