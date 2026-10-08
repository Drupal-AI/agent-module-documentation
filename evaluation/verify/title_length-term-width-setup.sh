#!/usr/bin/env bash
# Introspection SETUP (title_length): widen the taxonomy term name DB column to a known size
# (617) via the title_length machinery. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("taxonomy_term_title_length.taxonomy_term")->changeLength(617);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: taxonomy_term_field_data.name widened to 617"
