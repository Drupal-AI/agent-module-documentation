#!/usr/bin/env bash
# Execution CLEANUP: delete block_styles config for 'bstyletaskb'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("block_styles");
  if ($e = $s->load("bstyletaskb")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: removed block_styles.blocks.bstyletaskb"
