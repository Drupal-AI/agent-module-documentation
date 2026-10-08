#!/usr/bin/env bash
# Execution CLEANUP: remove any block using the last_login_block plugin. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("block");
  foreach ($storage->loadByProperties(["plugin" => "last_login_block"]) as $b) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed all blocks using plugin last_login_block"
