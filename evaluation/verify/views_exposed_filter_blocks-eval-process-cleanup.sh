#!/usr/bin/env bash
# Introspection CLEANUP: remove the vefb_eval2 block created by the matching setup. Restores
# baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("vefb_eval2")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block.block.vefb_eval2 removed"
