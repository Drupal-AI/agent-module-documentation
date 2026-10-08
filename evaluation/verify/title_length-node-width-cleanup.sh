#!/usr/bin/env bash
# Introspection CLEANUP (title_length): restore the node title column to the module default
# 500 (EntityTitleLengthInterface::DEFAULT_LENGTH). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("node_title_length.node")->changeLength(500);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node_field_data.title restored to 500"
