#!/usr/bin/env bash
# Introspection CLEANUP (entity_delete_log): restore shipped default (log nothing) by clearing the
# entity_types selection. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("entity_delete_log.settings")->set("entity_types", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: entity_delete_log.settings entity_types reset to []"
