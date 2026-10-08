#!/usr/bin/env bash
# Execution CLEANUP: remove the block_classes_split placement. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("block_classes_split")) { $b->delete(); }
' >/dev/null 2>&1
echo "cleanup: block_classes_split removed"
