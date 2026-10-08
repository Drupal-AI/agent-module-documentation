#!/usr/bin/env bash
# Execution RESET: clear ignored_entity_types to empty so verify FAILS until the agent adds
# taxonomy_term. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("entity_bundle_permissions.settings")
    ->set("ignored_entity_types", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ignored_entity_types = [] (empty)"
