#!/usr/bin/env bash
# Execution CLEANUP: remove the block created by the matching reset (barl_task_menu), leaving
# the site at baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("barl_task_menu")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: barl_task_menu removed"
exit 0
