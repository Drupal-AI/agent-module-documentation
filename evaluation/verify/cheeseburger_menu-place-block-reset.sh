#!/usr/bin/env bash
# Execution RESET: ensure the block "cbm_task" does NOT exist, so verify FAILS on empty state
# until the agent places a cheeseburger_menu block with that id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("cbm_task")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block cbm_task absent"
