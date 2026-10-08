#!/usr/bin/env bash
# Execution CLEANUP: delete the mlist_task block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($b = \Drupal\block\Entity\Block::load("mlist_task")) { $b->delete(); }' >/dev/null 2>&1
echo "cleanup: block mlist_task removed"
