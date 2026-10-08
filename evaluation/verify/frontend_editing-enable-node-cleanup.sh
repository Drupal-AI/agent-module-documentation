#!/usr/bin/env bash
# Execution CLEANUP: restore baseline (no node bundles enabled), leaving paragraph entry intact.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("frontend_editing.settings");
  $e = $c->get("entity_types") ?: [];
  unset($e["node"]);
  $c->set("entity_types", $e)->save();
' >/dev/null 2>&1
echo "cleanup: frontend_editing.settings entity_types.node removed"
