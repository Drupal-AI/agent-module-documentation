#!/usr/bin/env bash
# Introspection SETUP (title_length): widen the node title DB column to a known size (731)
# via the title_length machinery, so an inspecting agent can read the live schema back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("node_title_length.node")->changeLength(731);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node_field_data.title widened to 731"
