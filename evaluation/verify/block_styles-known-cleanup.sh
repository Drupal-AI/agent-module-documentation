#!/usr/bin/env bash
# Introspection CLEANUP: delete the block_styles config entity 'bstyleknown'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_styles");
  if ($e = $s->load("bstyleknown")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: removed block_styles.blocks.bstyleknown"
