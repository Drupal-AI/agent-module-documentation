#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure the cf_task block does NOT exist, so verify FAILS on
# empty state until the agent places it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("cf_task")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block.block.cf_task absent"
