#!/usr/bin/env bash
# Execution RESET: ensure block vefb_task2 does NOT exist, so verify FAILS until the agent
# creates it correctly. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("vefb_task2")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block.block.vefb_task2 absent"
