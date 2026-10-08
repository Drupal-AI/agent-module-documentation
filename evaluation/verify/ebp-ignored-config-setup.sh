#!/usr/bin/env bash
# Introspection SETUP: write a known ignored_entity_types list to
# entity_bundle_permissions.settings so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("entity_bundle_permissions.settings")
    ->set("ignored_entity_types", ["taxonomy_term", "block_content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: entity_bundle_permissions.settings ignored_entity_types = [taxonomy_term, block_content]"
