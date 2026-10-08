#!/usr/bin/env bash
# Introspection SETUP (entity_delete_log): set a known set of logged entity types in config so an
# inspecting agent can read them back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("entity_delete_log.settings")->set("entity_types", ["taxonomy_term","user"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: entity_delete_log.settings entity_types = [taxonomy_term, user]"
