#!/usr/bin/env bash
# Introspection SETUP: flatten the pager onto the top-level response (pager_object_enabled=false),
# so an inspecting agent can read the output-shape setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pager_serializer.settings")
    ->set("pager_object_enabled",FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pager_serializer pager_object_enabled=false (pager flattened)"
