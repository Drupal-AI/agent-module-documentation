#!/usr/bin/env bash
# Introspection CLEANUP (ui_styles_block): delete the block placed by setup. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("ui_styles_eval_block")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block ui_styles_eval_block removed"
