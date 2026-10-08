#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("taxonomy_entity_index.settings")->set("types", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: taxonomy_entity_index.settings types=[]"
