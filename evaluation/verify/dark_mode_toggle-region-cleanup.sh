#!/usr/bin/env bash
# Introspection CLEANUP: remove the dmt_eval_known block placed by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("dmt_eval_known")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block dmt_eval_known removed"
