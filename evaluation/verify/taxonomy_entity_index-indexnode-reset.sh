#!/usr/bin/env bash
# Execution RESET: clear the indexed types so verify fails until the agent adds node. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("taxonomy_entity_index.settings")->set("types", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: taxonomy_entity_index.settings types=[]"
