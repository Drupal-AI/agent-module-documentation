#!/usr/bin/env bash
# Execution RESET: delete any block config entity using the google_translator plugin, so verify
# FAILS until the agent places the block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("block");
  foreach ($storage->loadMultiple() as $b) {
    if ($b->getPluginId() === "google_translator") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: removed all google_translator blocks"
