#!/usr/bin/env bash
# Execution CLEANUP (title_length): ensure the taxonomy term name column is at default 500.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("taxonomy_term_title_length.taxonomy_term")->changeLength(500);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: taxonomy_term_field_data.name set to 500"
