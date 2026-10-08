#!/usr/bin/env bash
# Introspection CLEANUP: remove block fcb_view. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("fcb_view")) { $b->delete(); }
' >/dev/null 2>&1
echo "cleanup: block fcb_view removed"
