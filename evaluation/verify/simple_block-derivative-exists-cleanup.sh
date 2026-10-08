#!/usr/bin/env bash
# Execution CLEANUP: remove simple_block sb_hero + clear block cache. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_block\Entity\SimpleBlock;
  if ($b = SimpleBlock::load("sb_hero")) { $b->delete(); }
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "removed: simple_block sb_hero"
