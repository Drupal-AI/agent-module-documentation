#!/usr/bin/env bash
# Introspection SETUP (node_title_length): widen node_field_data.title to a known 823 via the
# node_title_length.node service, so an inspecting agent can read the live schema. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("node_title_length.node")->changeLength(823);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node_field_data.title widened to 823"
