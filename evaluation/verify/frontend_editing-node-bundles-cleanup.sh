#!/usr/bin/env bash
# Introspection CLEANUP: remove the entity_types.node key (baseline had no node bundles
# enabled), leaving the paragraph entry intact. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("frontend_editing.settings");
  $e = $c->get("entity_types") ?: [];
  unset($e["node"]);
  $c->set("entity_types", $e)->save();
' >/dev/null 2>&1
echo "cleanup: frontend_editing.settings entity_types.node removed"
