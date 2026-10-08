#!/usr/bin/env bash
# Introspection CLEANUP: remove the seeded rows from the entity_update backup table.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("entity_update")->condition("entity_type", "eu_probe")->execute();
' >/dev/null 2>&1
echo "cleanup: eu_probe rows removed from the entity_update backup table"
