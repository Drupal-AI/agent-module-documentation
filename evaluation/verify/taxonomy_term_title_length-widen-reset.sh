#!/usr/bin/env bash
# Execution RESET (taxonomy_term_title_length): shrink the taxonomy term name column back to 255
# so verify FAILS until the agent widens term names to 620. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("taxonomy_term_title_length.taxonomy_term")->changeLength(255);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: taxonomy_term_field_data.name shrunk to 255"
