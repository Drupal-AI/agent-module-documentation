#!/usr/bin/env bash
# Execution RESET: ensure NO navigation_menu_role block nmr_task exists, so verify FAILS
# until the agent places one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("nmr_task")) { $b->delete(); }
' >/dev/null 2>&1
echo "reset: block nmr_task absent"
