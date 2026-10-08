#!/usr/bin/env bash
# Introspection CLEANUP: remove the vefb_eval block created by the matching setup. Restores
# baseline (no vefb_eval block). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("vefb_eval")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block.block.vefb_eval removed"
