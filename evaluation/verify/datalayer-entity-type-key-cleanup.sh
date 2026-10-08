#!/usr/bin/env bash
# MEDIUM cleanup: restore entity_type to its install default (entityType).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("datalayer.settings")
    ->set("entity_type", "entityType")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: datalayer.settings entity_type restored to entityType"
