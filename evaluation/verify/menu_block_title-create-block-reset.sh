#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure block mbt_built does NOT exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("mbt_built")) { $b->delete(); }' >/dev/null 2>&1
echo "reset: block.block.mbt_built removed"
