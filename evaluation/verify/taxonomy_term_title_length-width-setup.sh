#!/usr/bin/env bash
# Introspection SETUP (taxonomy_term_title_length): widen the taxonomy term name column to a
# known 777 via the taxonomy_term_title_length.taxonomy_term service, so an inspecting agent can
# read the live schema. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("taxonomy_term_title_length.taxonomy_term")->changeLength(777);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: taxonomy_term_field_data.name widened to 777"
