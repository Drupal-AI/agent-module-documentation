#!/usr/bin/env bash
# Introspection CLEANUP: remove the block instance created by the matching setup.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("formblock_fb_known")) { $b->delete(); }
' >/dev/null 2>&1
echo "cleanup: block.block.formblock_fb_known removed"
