#!/usr/bin/env bash
# Introspection CLEANUP: remove block fcb_known. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("fcb_known")) { $b->delete(); }
' >/dev/null 2>&1
echo "cleanup: block fcb_known removed"
