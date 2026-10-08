#!/usr/bin/env bash
# Execution RESET: remove any Text Resize block placement so verify FAILS until the agent
# places the text_resize_block in a region.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $id => $b) {
    if ($b->getPluginId() === "text_resize_block") { $b->delete(); }
  }
' >/dev/null 2>&1
echo "reset: all text_resize_block placements removed"
