#!/usr/bin/env bash
# Execution RESET (message_subscribe_ui): delete all placements of the message_subscribe_ui_block so
# verify FAILS until the agent places the "Manage subscriptions" block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "message_subscribe_ui_block") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: removed all message_subscribe_ui_block placements"
