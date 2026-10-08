#!/usr/bin/env bash
# Introspection CLEANUP: restore simplify.global's node setting to its install default (empty
# array), undoing the known set placed by the matching setup script. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("simplify.global")
    ->set("simplify_nodes_global", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: simplify_nodes_global reset to []"
