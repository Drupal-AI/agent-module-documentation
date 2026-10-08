#!/usr/bin/env bash
# Introspection CLEANUP: delete block mbt_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("mbt_known")) { $b->delete(); }' >/dev/null 2>&1
echo "cleanup: block.block.mbt_known removed"
