#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("taxonomy_entity_index.settings")
    ->set("types", [])->set("index_revisions", FALSE)->set("index_per_field", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: taxonomy_entity_index.settings reset"
