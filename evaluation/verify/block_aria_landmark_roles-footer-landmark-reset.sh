#!/usr/bin/env bash
# Execution RESET: delete the footer block the agent must create (barl_task_footer) so verify
# fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("barl_task_footer")) { $b->delete(); }
  print "reset: barl_task_footer present=" . (Block::load("barl_task_footer") ? "yes" : "no") . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
exit 0
