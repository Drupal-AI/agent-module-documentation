#!/usr/bin/env bash
# Execution RESET: ensure cloning is NOT enabled for node.page (delete its config object) so verify
# FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("content_entity_clone.bundle.settings.node.page")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: content_entity_clone.bundle.settings.node.page removed (cloning off for Basic page)"
