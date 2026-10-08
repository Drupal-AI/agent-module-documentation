#!/usr/bin/env bash
# Introspection SETUP (node_title_length): set node_field_data.title to a deliberately
# non-default 384 chars, so an agent that assumes "500" is wrong and must read the real schema.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("node_title_length.node")->changeLength(384);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node_field_data.title set to 384"
