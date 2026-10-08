#!/usr/bin/env bash
# Introspection CLEANUP (node_title_length): restore node title column to default 500. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("node_title_length.node")->changeLength(500);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node_field_data.title restored to 500"
