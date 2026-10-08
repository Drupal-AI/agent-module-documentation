#!/usr/bin/env bash
# Execution RESET: ensure NO node bundles are enabled for frontend editing (remove the
# entity_types.node key) so verify FAILS until the agent enables one. Leaves paragraph entry
# intact. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("frontend_editing.settings");
  $e = $c->get("entity_types") ?: [];
  unset($e["node"]);
  $c->set("entity_types", $e)->save();
' >/dev/null 2>&1
echo "reset: frontend_editing.settings entity_types.node removed"
