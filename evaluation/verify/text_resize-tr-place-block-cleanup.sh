#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $id => $b) {
    if ($b->getPluginId() === "text_resize_block") { $b->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: text_resize_block placements removed"
