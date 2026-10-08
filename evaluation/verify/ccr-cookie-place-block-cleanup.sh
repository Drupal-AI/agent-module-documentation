#!/usr/bin/env bash
# Execution CLEANUP: delete the task block.
set -uo pipefail
cd /var/www/html
drush php:eval 'if($b=\Drupal\block\Entity\Block::load("ccr_switcher_task")){$b->delete();}' >/dev/null 2>&1
echo "cleanup: block ccr_switcher_task deleted"
