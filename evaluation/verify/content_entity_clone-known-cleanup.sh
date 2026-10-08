#!/usr/bin/env bash
# Introspection CLEANUP: delete the node.article cloning config object. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("content_entity_clone.bundle.settings.node.article")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: content_entity_clone.bundle.settings.node.article deleted"
