#!/usr/bin/env bash
# Execution RESET: ensure block fb_task does NOT exist, so verify FAILS until placed.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("fb_task")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block fb_task removed (absent)"
