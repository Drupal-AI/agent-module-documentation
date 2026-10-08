#!/usr/bin/env bash
# Introspection CLEANUP: delete the block placed by the matching setup (which also removes its
# third-party settings). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("barl_eval_block")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block barl_eval_block removed"
exit 0
