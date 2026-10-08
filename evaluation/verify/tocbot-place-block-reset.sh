#!/usr/bin/env bash
# Execution RESET (tocbot): delete every block placement using the tocbot_block plugin, so the
# "Tocbot TOC" block is not placed anywhere. verify FAILS until the agent places it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "tocbot_block") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: removed all tocbot_block placements"
