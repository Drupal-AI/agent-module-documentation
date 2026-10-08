#!/usr/bin/env bash
# Execution RESET: delete the block the agent is asked to create (fieldblock_task_body) so
# verify fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("fieldblock_task_body")) { $b->delete(); }
  print "reset: fieldblock_task_body present=" . (Block::load("fieldblock_task_body") ? "yes" : "no") . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
exit 0
