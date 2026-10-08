#!/usr/bin/env bash
# Execution CLEANUP: delete block mbt_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("mbt_task")) { $b->delete(); }' >/dev/null 2>&1
echo "cleanup: block.block.mbt_task removed"
