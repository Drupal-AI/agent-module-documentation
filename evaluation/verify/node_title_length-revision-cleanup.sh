#!/usr/bin/env bash
# Execution CLEANUP (node_title_length): restore node title columns to default 500. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("node_title_length.node")->changeLength(500);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node title columns restored to 500"
