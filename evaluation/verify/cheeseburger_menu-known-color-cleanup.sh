#!/usr/bin/env bash
# Introspection CLEANUP: remove the block placed by the matching setup. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("cbm_known")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block cbm_known removed"
