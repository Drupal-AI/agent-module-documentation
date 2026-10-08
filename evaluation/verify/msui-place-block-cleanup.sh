#!/usr/bin/env bash
# Execution CLEANUP (message_subscribe_ui): remove any message_subscribe_ui_block placements. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "message_subscribe_ui_block") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed all message_subscribe_ui_block placements"
