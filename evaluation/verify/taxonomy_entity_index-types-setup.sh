#!/usr/bin/env bash
# Introspection SETUP: configure the module to index the 'node' entity type and to keep revision
# indexes, so an agent can read the live settings back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("taxonomy_entity_index.settings")
    ->set("types", ["node"])->set("index_revisions", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: taxonomy_entity_index.settings types=[node] index_revisions=TRUE"
