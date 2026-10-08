#!/usr/bin/env bash
# Execution CLEANUP: delete the blocache_task block built during the case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("blocache_task")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block blocache_task removed"
