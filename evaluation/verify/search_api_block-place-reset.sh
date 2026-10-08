#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure block sab_task does NOT exist (so verify FAILS on empty
# state). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($b = \Drupal\block\Entity\Block::load("sab_task")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block.block.sab_task absent"
