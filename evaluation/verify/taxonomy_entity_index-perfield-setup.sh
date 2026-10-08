#!/usr/bin/env bash
# Introspection SETUP: enable per-field indexing (index_per_field) while indexing node. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("taxonomy_entity_index.settings")
    ->set("types", ["node"])->set("index_per_field", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: taxonomy_entity_index.settings index_per_field=TRUE"
