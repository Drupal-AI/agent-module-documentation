#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline entity_export_csv.settings (only node enabled) by
# removing the user entity type key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("entity_export_csv.settings");
  $types = $c->get("entity_types") ?: [];
  unset($types["user"]);
  $c->set("entity_types", $types)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: entity_export_csv.settings user entity type removed (baseline: node only)"
