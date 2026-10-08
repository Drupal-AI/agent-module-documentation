#!/usr/bin/env bash
# Execution RESET (node_title_length): shrink node title columns (data + revision) back to 255 so
# verify FAILS until the agent widens node titles to 640. changeLength() updates both tables.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("node_title_length.node")->changeLength(255);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node title columns (data + revision) shrunk to 255"
