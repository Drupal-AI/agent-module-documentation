#!/usr/bin/env bash
# Execution RESET: ensure no block named tc_overview_block exists, so verify FAILS until the agent
# places a Total Control pane block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("tc_overview_block")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block tc_overview_block absent"
