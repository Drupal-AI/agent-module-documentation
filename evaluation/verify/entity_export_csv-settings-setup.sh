#!/usr/bin/env bash
# Introspection SETUP: enable the 'user' entity type for export in entity_export_csv.settings
# (baseline only has node enabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("entity_export_csv.settings");
  $c->set("entity_types.user.enable", TRUE);
  $c->set("entity_types.user.limit_per_bundle", []);
  $c->set("entity_types.user.bundles", []);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: entity_export_csv.settings entity_types.user.enable = true"
