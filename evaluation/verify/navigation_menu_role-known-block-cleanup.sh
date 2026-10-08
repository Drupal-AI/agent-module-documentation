#!/usr/bin/env bash
# Introspection CLEANUP: delete the nmr_known block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("nmr_known")) { $b->delete(); }
' >/dev/null 2>&1
echo "cleanup: block nmr_known removed"
