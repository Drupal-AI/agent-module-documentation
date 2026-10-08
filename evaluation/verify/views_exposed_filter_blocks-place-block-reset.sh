#!/usr/bin/env bash
# Execution RESET: ensure the block vefb_task does NOT exist, so verify FAILS until the agent
# creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("vefb_task")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block.block.vefb_task absent"
