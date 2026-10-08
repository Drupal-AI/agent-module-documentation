#!/usr/bin/env bash
# Introspection CLEANUP (taxonomy_term_title_length): restore term name column to default 500.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("taxonomy_term_title_length.taxonomy_term")->changeLength(500);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: taxonomy_term_field_data.name restored to 500"
