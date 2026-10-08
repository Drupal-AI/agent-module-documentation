#!/usr/bin/env bash
# Execution RESET: turn revision indexing OFF (and clear types) so verify fails until enabled. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("taxonomy_entity_index.settings")
    ->set("types", [])->set("index_revisions", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: taxonomy_entity_index.settings index_revisions=FALSE types=[]"
