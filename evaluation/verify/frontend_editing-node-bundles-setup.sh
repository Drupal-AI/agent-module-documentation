#!/usr/bin/env bash
# Introspection SETUP: enable frontend editing for node bundles article + page by writing the
# entity_types.node key in frontend_editing.settings, so an agent can read which node bundles
# are editable. Leaves the existing paragraph entry untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("frontend_editing.settings");
  $e = $c->get("entity_types") ?: [];
  $e["node"] = ["article", "page"];
  $c->set("entity_types", $e)->save();
' >/dev/null 2>&1
echo "setup: frontend_editing.settings entity_types.node=[article,page]"
