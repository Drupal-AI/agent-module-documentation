#!/usr/bin/env bash
# Introspection CLEANUP: restore fitvids.settings selectors to the shipped default (.node).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fitvids.settings")->set("selectors", ".node")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fitvids.settings selectors restored to .node"
