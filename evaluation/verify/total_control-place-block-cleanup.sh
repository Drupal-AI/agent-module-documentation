#!/usr/bin/env bash
# Execution CLEANUP: delete the tc_overview_block block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("tc_overview_block")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tc_overview_block removed"
