#!/usr/bin/env bash
# Introspection CLEANUP: delete block_styles config for 'bsboot_known'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_styles");
  if ($e = $s->load("bsboot_known")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: removed block_styles.blocks.bsboot_known"
