#!/usr/bin/env bash
# Introspection CLEANUP: remove both block placements created by the matching setup. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (["block_classes_alpha", "block_classes_beta"] as $id) {
    if ($b = Block::load($id)) { $b->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: block_classes_alpha and block_classes_beta removed"
