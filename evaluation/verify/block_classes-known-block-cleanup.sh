#!/usr/bin/env bash
# Introspection CLEANUP: remove the block placement created by the matching setup, which also
# removes its Block Classes third-party settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("block_classes_known")) { $b->delete(); }
' >/dev/null 2>&1
echo "cleanup: block_classes_known removed"
