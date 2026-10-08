#!/usr/bin/env bash
# Introspection CLEANUP: remove the fixture block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("dmsuperfish_known")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block dmsuperfish_known removed"
