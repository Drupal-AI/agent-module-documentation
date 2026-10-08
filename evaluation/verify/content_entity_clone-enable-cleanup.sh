#!/usr/bin/env bash
# Execution CLEANUP: delete the node.page cloning config object. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("content_entity_clone.bundle.settings.node.page")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: content_entity_clone.bundle.settings.node.page deleted"
