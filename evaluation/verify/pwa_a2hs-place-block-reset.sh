#!/usr/bin/env bash
# Execution RESET: ensure block 'pwa_a2hs_task' does NOT exist so verify FAILS until placed.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if($b=Block::load("pwa_a2hs_task")){$b->delete();}' >/dev/null 2>&1
echo "reset: block pwa_a2hs_task absent"
