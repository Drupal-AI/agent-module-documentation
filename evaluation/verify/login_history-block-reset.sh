#!/usr/bin/env bash
# Execution RESET: delete any block config entity using the last_login_block plugin so verify
# fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("block");
  foreach ($storage->loadByProperties(["plugin" => "last_login_block"]) as $b) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: removed all blocks using plugin last_login_block"
