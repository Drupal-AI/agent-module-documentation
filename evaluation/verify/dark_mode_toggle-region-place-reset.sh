#!/usr/bin/env bash
# Execution RESET: delete all dark_mode_toggle block placements so the region-specific verify
# FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (Block::loadMultiple() as $b) { if ($b->getPluginId() === "dark_mode_toggle") { $b->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no dark_mode_toggle blocks remain"
