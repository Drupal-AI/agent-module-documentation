#!/usr/bin/env bash
# Execution RESET: ensure simple_block sb_task ABSENT so verify FAILS until created. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_block\Entity\SimpleBlock;
  if ($b = SimpleBlock::load("sb_task")) { $b->delete(); }
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "removed: simple_block sb_task"
