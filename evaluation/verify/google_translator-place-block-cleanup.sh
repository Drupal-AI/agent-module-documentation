#!/usr/bin/env bash
# Remove any google_translator block created during the case. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("block");
  foreach ($storage->loadMultiple() as $b) {
    if ($b->getPluginId() === "google_translator") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed all google_translator blocks"
