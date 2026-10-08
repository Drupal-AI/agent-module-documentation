#!/usr/bin/env bash
# Execution RESET/CLEANUP: delete ALL block config entities using the Superfish domain-menu plugin,
# so verify FAILS until the agent places one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "domain_menus_active_domain_superfish_block") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no domain_menus_active_domain_superfish_block placements remain"
