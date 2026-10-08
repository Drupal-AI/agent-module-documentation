#!/usr/bin/env bash
# Execution CLEANUP (tocbot): remove any tocbot_block placements created during the case. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "tocbot_block") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed all tocbot_block placements"
